//
//  StudentSignup.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 06/04/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class StudentSignup: baseviewcontroller,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIAlertViewDelegate,UIScrollViewDelegate{
    
    @IBOutlet var scrl: UIScrollView!
    @IBOutlet var year: UIPickerView!
    @IBOutlet var programme: UIPickerView!
    @IBOutlet var gender: UIPickerView!
    @IBOutlet var password: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var room: UITextField!
    @IBOutlet var mobile: UITextField!
    @IBOutlet var roll: UITextField!
    @IBOutlet var name: UITextField!
    
    var gend = ["M","F"]
    var gend1:String!
    var stud:student! = student()
    var yr = [1,2,3,4]
    var yr1:Int!
    var prg = ["UG","M.Sc","M.Tech","PhD"]
    var prg1:String!
    
    func doneButtonAction() {
        self.mobile.resignFirstResponder()
        self.room.resignFirstResponder()
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.mobile.inputAccessoryView = doneToolbar
        self.room.inputAccessoryView = doneToolbar
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        scrl.setContentOffset(CGPoint(x:0,y:0), animated: true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if(textField==email){
            scrl.setContentOffset(CGPoint(x:0,y:340), animated: true)
        }
        if(textField==password){
            scrl.setContentOffset(CGPoint(x:0,y:400), animated: true)
        }
        if(textField==name || textField==roll || textField==mobile){
            scrl.setContentOffset(CGPoint(x:0,y:0), animated: true)
        }
        if(textField==room){
            scrl.setContentOffset(CGPoint(x:0,y:200), animated: true)
        }
        return true
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrl.isScrollEnabled = true
        email.resignFirstResponder()
        mobile.resignFirstResponder()
        name.resignFirstResponder()
        roll.resignFirstResponder()
        password.resignFirstResponder()
        room.resignFirstResponder()
        scrl.setContentOffset(CGPoint(x:0,y:0), animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        name.resignFirstResponder()
        roll.resignFirstResponder()
        mobile.resignFirstResponder()
        email.resignFirstResponder()
        password.resignFirstResponder()
        room.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView==gender){
            return gend.count
        }
        if(pickerView==programme){
            return prg.count
        }
        return yr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView==gender){
            return gend[row]
        }
        if(pickerView==programme){
            return prg[row]
        }
        return String(yr[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView==gender){
            gend1=gend[row]
        }
        if(pickerView==programme){
            prg1=prg[row]
            if(prg1=="M.Sc" || prg1=="M.Tech"){
                if(yr.count==4){
                    yr.removeLast()
                }
                year.reloadAllComponents()
            }
            else{
                if(yr.count==3){
                    yr.append(4)
                }
                year.reloadAllComponents()
            }
            
        }
        if(pickerView==year){
            yr1=yr[row]
            if(yr1==1){
                room.isUserInteractionEnabled = false
                room.text=""
            }
            else{
                room.isUserInteractionEnabled = true
            }
        }
        self.view.endEditing(true)
    }
    @IBAction func cancel(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait)
        name.text=""
        roll.text=""
        mobile.text=""
        email.text=""
        password.text=""
    }
    
    @IBAction func sgnup(sender: AnyObject) {
        if((password.text?.characters.count)!<6){
            let sheet=UIAlertController.init(title: "Password should be more than 6 characters", message: nil, preferredStyle: .alert)
            let okay=UIAlertAction.init(title: "OK", style: .default){
                (ACTION) -> Void in
                sheet.dismiss(animated: true, completion: nil)
                self.view.alpha=1.0
            }
            sheet.addAction(okay)
            self.present(sheet, animated: true, completion: nil)
            self.view.alpha=0.5
            return
        }
        
        
                if(validateString(name.text!) && validateString(roll.text!) && validateString(mobile.text!) && validateString(email.text!) && validateString(password.text!) && isValidEmail(testStr: email.text!) && isValidMobile(testStr: mobile.text!)){
                    stud.set_mobile(mob: mobile.text)
                    stud.set_name(nm: name.text)
                    stud.set_year(yr: yr1)
                    stud.set_programme(pg: prg1)
                    stud.set_gender(gend: gend1)
                    stud.set_roll(rll: roll.text)
                    stud.set_email(em: email.text)
                    stud.set_password(pass: password.text)
                    if(yr1==1){
                        stud.set_room(rm: 0)
                    }
                    else{
                        stud.set_room(rm: Int(room.text!)!)
                    }
                    
                    let db=DatabaseManager()
                    var dict:NSDictionary=["name":stud.get_name(),"roll":stud.get_roll(),"mobile":stud.get_mobile(),"Email":stud.get_email(),"room":stud.get_room(),"programme":stud.get_programme(),"year":stud.get_year(),"gender":stud.get_gender(),"password":stud.get_password()]
                    var flag = false
                    db.GeneratePostString(dict:dict)
                    if(isInternetAvailable()==false){
                        let sheet=UIAlertController.init(title: "Please check your Internet connection", message: nil, preferredStyle: .alert)
                        let okay=UIAlertAction.init(title: "OK", style: .default){
                            (ACTION) -> Void in
                            sheet.dismiss(animated: true, completion: nil)
                            self.view.alpha=1.0
                        }
                        sheet.addAction(okay)
                        self.present(sheet, animated: true, completion: nil)
                        self.view.alpha=0.5
                        return
                    }
                    db.GetRequest(url: "http://onetouch.16mb.com/room_manage/signup.php")
                    DispatchQueue.global(qos: .userInteractive).async {
                        flag=db.CreateTask(view: self.view)
                        
                    }
                    while(flag != true){
                        
                    }
                    
                    let json=(db.getjson())[0] as! [String:String]
                    if(json["flag"]=="1"){
                        let sheet=UIAlertController.init(title: "Email already exists", message: nil, preferredStyle: .alert)
                        let okay=UIAlertAction.init(title: "OK", style: .default){
                            (ACTION) -> Void in
                            sheet.dismiss(animated: true, completion: nil)
                            self.view.alpha=1.0
                        }
                        sheet.addAction(okay)
                        self.present(sheet, animated: true, completion: nil)
                        self.view.alpha=0.5
                        return
                    }
                    else if(json["flag"]=="2"){
                        let sheet=UIAlertController.init(title: "Roll Number already exists", message: nil, preferredStyle: .alert)
                        let okay=UIAlertAction.init(title: "OK", style: .default){
                            (ACTION) -> Void in
                            sheet.dismiss(animated: true, completion: nil)
                            self.view.alpha=1.0
                        }
                        sheet.addAction(okay)
                        self.present(sheet, animated: true, completion: nil)
                        self.view.alpha=0.5
                        return
                    }
                    else if(json["flag"]=="3"){
                        let sheet=UIAlertController.init(title: "The provided Room Number does not exist", message: nil, preferredStyle: .alert)
                        let okay=UIAlertAction.init(title: "OK", style: .default){
                            (ACTION) -> Void in
                            sheet.dismiss(animated: true, completion: nil)
                            self.view.alpha=1.0
                        }
                        sheet.addAction(okay)
                        self.present(sheet, animated: true, completion: nil)
                        self.view.alpha=0.5
                        return
                    }
                    else{
                        let sheet=UIAlertController.init(title: "User Successfully Created", message: nil, preferredStyle: .alert)
                        let okay=UIAlertAction.init(title: "OK", style: .default){
                            (ACTION) -> Void in
                            sheet.dismiss(animated: true, completion: nil)
                            self.view.alpha=1.0
                            self.dismiss(animated: true, completion: nil)
                            self.dismiss(animated: true, completion: nil)
                            return
                        }
                        sheet.addAction(okay)
                        self.present(sheet, animated: true, completion: nil)
                        self.view.alpha=0.5
                        
                    }
                    
                }
                else{
                    let sheet=UIAlertController.init(title: "Check your Internet Connection", message: nil, preferredStyle: .alert)
                    let okay=UIAlertAction.init(title: "OK", style: .default){
                        (ACTION) -> Void in
                        sheet.dismiss(animated: true, completion: nil)
                        self.view.alpha=1.0
                    }
                    sheet.addAction(okay)
                    self.present(sheet, animated: true, completion: nil)
                    self.view.alpha=0.5
                    return
                }
            }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDoneButtonOnKeyboard()
        gender.dataSource=self
        gender.delegate=self
        programme.dataSource=self
        programme.delegate=self
        year.dataSource=self
        year.delegate=self
        name.delegate=self
        roll.delegate=self
        mobile.delegate=self
        room.delegate=self
        email.delegate=self
        password.delegate=self
        gend1=gend[0]
        yr1=yr[0]
        prg1=prg[0]
        name.text!=""
        roll.text!=""
        mobile.text!=""
        email.text!=""
        password.text!=""
        room.text!=""
        room.isUserInteractionEnabled = false
        self.view.isUserInteractionEnabled=true
        scrl.canCancelContentTouches=false
        scrl.delaysContentTouches=true
    }
}
