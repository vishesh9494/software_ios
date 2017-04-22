//
//  login.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 23/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class login: baseviewcontroller,UITextFieldDelegate{
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    var stude=student()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        email.text=""
        password.text=""
        AppUtility.lockOrientation(.portrait)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        email.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.email.resignFirstResponder()
        self.password.resignFirstResponder()
        return true
    }
    
    @IBAction func login(_ sender: Any) {
        if(validateString(email.text!) && validateString(password.text!)){
            //check if it is student, CS or HMC
            if(email.text=="hmc@iitj.ac.in" && password.text=="hmciitjodhpur"){
                if(isInternetAvailable()==true){
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "hmcLogin")
                self.present(vc!, animated: true, completion: nil)
                }
                else{
                    let sheet=UIAlertController.init(title: "Please check your Internet connection", message: nil, preferredStyle: .alert)
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
                var inDatabase:Bool = false
                
                let db=DatabaseManager()
                var dict:NSDictionary=["email":email.text,"password":password.text]
                var flag = false
                db.GeneratePostString(dict:dict)
                if(isInternetAvailable()==true){
                    db.GetRequest(url: "http://onetouch.16mb.com/room_manage/login.php")
                    DispatchQueue.global(qos: .userInteractive).async {
                        flag=db.CreateTask(view: self.view)
                        
                    }
                    while(flag != true){
                        
                    }
                    var pjson=(db.getjson())[0] as! [String:String]
                    if(pjson["network"]=="1"){
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
                    pjson=(db.getjson())[1] as! [String:String]
                    if(pjson["flag"] == "1"){
                        inDatabase=true
                        
                        self.stude.set_programme(pg: pjson["Programme"])
                        self.stude.set_gender(gend: pjson["Gender"])
                        self.stude.set_room_no(rm: Int(pjson["RoomNo"]!)!)
                        self.stude.set_mobile(mob: pjson["Mobile"])
                        self.stude.set_roll(rll: pjson["Rollno"])
                        self.stude.set_email(em: self.email.text!)
                        self.stude.set_year(yr: Int(pjson["Year"]!)!)
                        self.stude.set_name(nm: pjson["Name"])
                        
                    }
                    else{
                        inDatabase=false
                    }
                    
                    
                    //check if email and password are in database
                    if(inDatabase==true){
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "studentLogin") as! studentLogin
                        vc.stud=stude
                        self.present(vc, animated: true, completion: nil)
                    }
                    else{
                        let sheet = UIAlertController.init(title: "Email and Password are Incorrect", message: nil, preferredStyle: .alert)
                        let okay = UIAlertAction.init(title: "OK", style: .default){
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
                    let sheet=UIAlertController.init(title: "Please check your Internet connection", message: nil, preferredStyle: .alert)
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
    
    @IBAction func signup(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StudentSignup") as! StudentSignup
        self.present(vc, animated: true, completion: nil)
    }
}
