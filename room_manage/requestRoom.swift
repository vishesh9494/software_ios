//
//  requestRoom.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 27/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class requestRoom: baseviewcontroller{
    var stud:student = student()
    
    @IBOutlet weak var room: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        room.resignFirstResponder()
    }
    
    @IBAction func request1(_ sender: Any) {
        if(validateString(room.text!)){
            var isValid:Bool = true //room is valid
            //check if room is valid or not
            
            
            
            let db = databaseManager()
            var request1 = URLRequest(url: URL(string: "http://onetouch.16mb.com/room_manage/validateroom.php")!)
            request1.httpMethod = "POST"
            let postString:String = "roomno=\(room.text!)"
            request1.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request1) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(error)")
                    return
                }
                do{
                    let json=try JSONSerialization.jsonObject(with: data, options: .allowFragments ) as! [String:String]
                    print(json["roomno"],json["gender"],json["Year"],json["Programme"],json["capacity"])
                    if(Int(json["capacity"]!)! == 0 || json["gender"] != self.stud.get_gender() || Int(json["Year"]!)  != self.stud.get_year() || json["Programme"] != self.stud.get_programme()){
                        isValid=false
                    }
                    
                }
                catch let parseError {
                    print("parsing error: \(parseError)")
                    let responseString = String(data: data, encoding: .utf8)
                    print("raw response: \(responseString)")
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
            if(isValid==true){
                let sheet = UIAlertController.init(title: "Request sent to HMC", message: nil, preferredStyle: .alert)
                let okay = UIAlertAction.init(title: "OK", style: .default){
                    (ACTION) -> Void in
                    sheet.dismiss(animated: true, completion: nil)
                    
                    //add request to database
                    var req:request = request()
                    req.set_room(rm: Int(self.room.text!)!)
                    req.set_student(EmailID: self.stud.get_email())
                    req.set_status(st: "Pending")
                    let db = databaseManager()
                    var request1 = URLRequest(url: URL(string: "http://onetouch.16mb.com/room_manage/requestroom.php")!)
                    request1.httpMethod = "POST"
                    let postString:String = "email=\(self.stud.get_email())&Room=\(req.get_room())&Status=\(req.get_status())"
                    request1.httpBody = postString.data(using: .utf8)
                    let task = URLSession.shared.dataTask(with: request1) { data, response, error in
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
                    }
                    
                    task.resume()
                    
                    
                    
                    
                    
                    self.dismiss(animated: true, completion: nil)
                    self.view.alpha=1.0
                }
                sheet.addAction(okay)
                self.present(sheet, animated: true, completion: nil)
                self.view.alpha=0.5
            }
            else{
                let sheet = UIAlertController.init(title: "Room no. not valid", message: nil, preferredStyle: .alert)
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
            let sheet = UIAlertController.init(title: "Room no. not valid", message: nil, preferredStyle: .alert)
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
