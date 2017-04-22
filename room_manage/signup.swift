//
//  signup.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 21/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class signup:baseviewcontroller,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIAlertViewDelegate,UIScrollViewDelegate{
    
    @IBOutlet var scrl: UIScrollView!
    @IBOutlet weak var room: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var roll: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var gender: UIPickerView!
    @IBOutlet weak var programme: UIPickerView!
    @IBOutlet weak var year: UIPickerView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var gend = ["male","female"]
    var gend1:String!
    var stud:student! = student()
    var yr = [1,2,3,4]
    var yr_1 = [1,2,3]
    var yr1:Int!
    var prg = ["UG","M.Sc","M.Tech","PhD"]
    var prg1:String!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrl.delegate = self
        //scroll.delegate=self
        //scroll.isUserInteractionEnabled=true
        //scroll.contentSize = view.frame.size
        //view.addSubview(scroll)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        name.resignFirstResponder()
        roll.resignFirstResponder()
        mobile.resignFirstResponder()
        email.resignFirstResponder()
        password.resignFirstResponder()
        room.resignFirstResponder()
    }
    func textFieldShouldBeginEditing(_ email: UITextField) -> Bool {
        //scroll.setContentOffset(CGPoint(x: 0, y: 140), animated: true)
        return true
    }
    func textFieldShouldReturn(_ email: UITextField) -> Bool {
        email.resignFirstResponder()
        //scroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        return true
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
        }
        if(pickerView==year){
            yr1=yr[row]
            if(yr1==1){
                room.text=""
                room.isUserInteractionEnabled = false
            }
            else{
                room.isUserInteractionEnabled = true
            }
        }
        self.view.endEditing(true)
    }
    override func viewDidAppear(_ animated: Bool) {
        name.text = "Vishes"
        roll.text = "B15CS038"
        mobile.text="234824"
        email.text = "nine"
        password.text = "pass"
        AppUtility.lockOrientation(.portrait)
    }
    
    @IBAction func sgnup(_ sender: Any) {
        if(validateString(name.text!) && validateString(roll.text!) && validateString(mobile.text!) && validateString(email.text!) && validateString(password.text!) && isValidEmail(testStr: email.text!) && isValidMobile(testStr: mobile.text!)){
            stud.set_mobile(mob: mobile.text)
            stud.set_name(nm: name.text)
            stud.set_year(yr: yr1)
            stud.set_programme(pg: prg1)
            stud.set_gender(gend: gend1)
            stud.set_roll(rll: roll.text)
            stud.set_email(em: email.text)
            stud.set_password(pass: password.text)
            
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
            if(json["flag"]=="0"){
                let sheet=UIAlertController.init(title: "Username already exists", message: nil, preferredStyle: .alert)
                let okay=UIAlertAction.init(title: "OK", style: .default){
                    (ACTION) -> Void in
                    sheet.dismiss(animated: true, completion: nil)
                    self.view.alpha=1.0
                }
                sheet.addAction(okay)
                self.present(sheet, animated: true, completion: nil)
                self.view.alpha=0.5
            }
            else if(json["flag"]=="1"){
                let sheet=UIAlertController.init(title: "Roll Number already exists", message: nil, preferredStyle: .alert)
                let okay=UIAlertAction.init(title: "OK", style: .default){
                    (ACTION) -> Void in
                    sheet.dismiss(animated: true, completion: nil)
                    self.view.alpha=1.0
                }
                sheet.addAction(okay)
                self.present(sheet, animated: true, completion: nil)
                self.view.alpha=0.5
            }
            else if(json["flag"]=="2"){
                let sheet=UIAlertController.init(title: "The provided Room Number does not exist", message: nil, preferredStyle: .alert)
                let okay=UIAlertAction.init(title: "OK", style: .default){
                    (ACTION) -> Void in
                    sheet.dismiss(animated: true, completion: nil)
                    self.view.alpha=1.0
                }
                sheet.addAction(okay)
                self.present(sheet, animated: true, completion: nil)
                self.view.alpha=0.5
            }
            
            
        }
        else{
            let sheet=UIAlertController.init(title: "Check your Credentials", message: nil, preferredStyle: .alert)
            let okay=UIAlertAction.init(title: "OK", style: .default){
                (ACTION) -> Void in
                sheet.dismiss(animated: true, completion: nil)
                self.view.alpha=1.0
            }
            sheet.addAction(okay)
            self.present(sheet, animated: true, completion: nil)
            self.view.alpha=0.5
        }

    }
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
