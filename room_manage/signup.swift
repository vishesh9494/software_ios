//
//  signup.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 21/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class signup:baseviewcontroller,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIAlertViewDelegate{
    
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
    var yr1:Int!
    var prg = ["UG","PG","M.Sc","M.Tech","PhD"]
    var prg1:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    @IBAction func sgnup(_ sender: Any) {
        if(validateString(name.text!) && validateString(roll.text!) && validateString(mobile.text!) && validateString(email.text!) && validateString(password.text!)){
            stud.set_mobile(mob: mobile.text)
            stud.set_name(nm: name.text)
            stud.set_year(yr: yr1)
            stud.set_programme(pg: prg1)
            stud.set_gender(gend: gend1)
            stud.set_roll(rll: roll.text)
            stud.set_email(em: email.text)
            stud.set_password(pass: password.text)
            let db = databaseManager()
            var request = URLRequest(url: URL(string: "http://onetouch.16mb.com/room_manage/signup.php")!)
            request.httpMethod = "POST"
            let postString:String = db.generatepost(stud: stud)
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(error)")
                    return
                }
                do{
                    let json=try JSONSerialization.jsonObject(with: data, options: .allowFragments ) as! NSArray
                }
                catch{
                    
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200{
                    print("statusCode should be 200 but is \(httpStatus.statusCode)")
                    print("response=\(response)")
                }
                let responseString = String(data: data,encoding: .utf8)
                print("responseString=\(responseString)")
                let sheet=UIAlertController.init(title: "User successully created", message: nil, preferredStyle: .alert)
                let okay=UIAlertAction.init(title: "OK", style: .default){
                    (ACTION) -> Void in
                    sheet.dismiss(animated: true, completion: nil)
                    self.dismiss(animated: true, completion: nil)
                    self.view.alpha=1.0
                }
                sheet.addAction(okay)
                self.present(sheet, animated: true, completion: nil)
                self.view.alpha=0.5
                //check if responseString is giving success or failure
                /*if(responseString=="error failed to connect to database"){
                    let sheet=UIAlertController.init(title: "Check your internet connection ", message: nil, preferredStyle: .alert)
                    let okay=UIAlertAction.init(title: "OK", style: .default){
                        (ACTION) -> Void in
                        sheet.dismiss(animated: true, completion: nil)
                        self.view.alpha=1.0
                    }
                    sheet.addAction(okay)
                    self.present(sheet, animated: true, completion: nil)
                    self.view.alpha=0.5
                }
                else if(responseString=="Already exists in the database"){
                    let sheet=UIAlertController.init(title: "The entered username already exists", message: "Try Again", preferredStyle: .alert)
                    let okay=UIAlertAction.init(title: "OK", style: .default){
                        (ACTION) -> Void in
                        sheet.dismiss(animated: true, completion: nil)
                        self.dismiss(animated: true, completion: nil)
                        self.view.alpha=1.0
                    }
                    sheet.addAction(okay)
                    self.present(sheet, animated: true, completion: nil)
                    self.view.alpha=0.5
                }*/
            }
            task.resume()
            
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
