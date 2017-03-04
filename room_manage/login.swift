//
//  login.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 23/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class login: baseviewcontroller{
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    var stude=student()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        email.text="hmc@iitj.ac.in"
        password.text="hmciitjodhpur"
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        email.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    @IBAction func login(_ sender: Any) {
        if(validateString(email.text!) && validateString(password.text!)){
            //check if it is student, CS or HMC
            if(email.text=="hmc@iitj.ac.in" && password.text=="hmciitjodhpur"){
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "hmcLogin")
                self.present(vc!, animated: true, completion: nil)
            }
            else{
                var inDatabase:Bool = false
                
                //check if email and password are in database
                var request = URLRequest(url: URL(string: "http://onetouch.16mb.com/room_manage/login.php")!)
                request.httpMethod = "POST"
                let postString:String = "email=\(email.text!)&password=\(password.text!)"
                request.httpBody = postString.data(using: .utf8)
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {                                                 // check for fundamental networking error
                        print("error=\(error)")
                        return
                    }
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments ) as! NSArray
                        let pjson=json[0] as! [String:String]
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
                    
                        
                    }
                    catch{
                        
                    }
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200{
                        print("statusCode should be 200 but is \(httpStatus.statusCode)")
                        print("response=\(response)")
                    }
                    let responseString = String(data: data,encoding: .utf8)
                    print("responseString=\(responseString)")
                                    }
                
                task.resume()
                sleep(4);
                
                if(inDatabase==true){
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "studentLogin") as! studentLogin
                    vc.stud=stude
                    self.present(vc, animated: true, completion: nil)
                }
                else{
                    let sheet = UIAlertController.init(title: "Email and Password are incorrect", message: nil, preferredStyle: .alert)
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
