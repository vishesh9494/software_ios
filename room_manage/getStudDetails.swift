//
//  getStudDetails.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 27/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class getStudDetails: baseviewcontroller{
    
    @IBOutlet weak var email: UITextField!
    
    var stud:student = student()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        email.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submit(_ sender: Any) {
        if(validateString(email.text!)){
            if(email.text=="hmc@iitj.ac.in" || email.text=="cs@iitj.ac.in"){
                let sheet = UIAlertController.init(title: "Email not of a student", message: nil, preferredStyle: .alert)
                let okay = UIAlertAction.init(title: "OK", style: .default){
                    (ACTION) -> Void in
                    sheet.dismiss(animated: true, completion: nil)
                    self.view.alpha=1.0
                }
                sheet.addAction(okay)
                self.present(sheet, animated: true, completion: nil)
                self.view.alpha=0.5
            }
            else{
                var inDatabase:Bool!
                //check if email is in database
                
                
                var request = URLRequest(url: URL(string: "http://onetouch.16mb.com/room_manage/getstuddetails.php")!)
                request.httpMethod = "POST"
                let postString:String = "email=\(email.text!)"
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
                            inDatabase=true;
                            self.stud.set_name(nm: pjson["Name"]);
                            self.stud.set_room(rm: Int(pjson["RoomNo"]!)!)
                            self.stud.set_year(yr: Int(pjson["Year"]!))
                            self.stud.set_email(em: self.email.text!)
                            self.stud.set_roll(rll: pjson["Rollno"])
                            self.stud.set_mobile(mob: pjson["Mobile"])
                            self.stud.set_gender(gend: pjson["Gender"])
                            self.stud.set_programme(pg: pjson["Programme"])
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
                sleep(5);

                
                
                
                
                
                //email is in database
                if(inDatabase == true){
                    //save all details of student in 'stud' object
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "getDetails") as! getDetails
                    vc.stud = stud
                    self.present(vc, animated: true, completion: nil)
                }
                else{
                    let sheet = UIAlertController.init(title: "Email not in database", message: nil, preferredStyle: .alert)
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
            let sheet = UIAlertController.init(title: "Email not valid", message: nil, preferredStyle: .alert)
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
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
