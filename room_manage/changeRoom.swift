//
//  changeRoom.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 27/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class changeRoom: baseviewcontroller{
    
    @IBOutlet weak var room: UITextField!
    
    var stud:student = student()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDoneButtonOnKeyboard()
    }
    
    func doneButtonAction() {
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
        
        self.room.inputAccessoryView = doneToolbar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        room.resignFirstResponder()
    }
    
    @IBAction func change(_ sender: Any) {
        if(validateString(room.text!)){
        if(room.text==String(stud.get_room())){
                let sheet = UIAlertController.init(title: "Room no. same as before", message: nil, preferredStyle: .alert)
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
                //check if room is in database
                //save room no to request database
                var req:request = request()
                req.set_room(rm: Int(room.text!)!)
                req.set_student(EmailID: stud.get_email())
                req.set_status(st: "Pending")
            
            let db=DatabaseManager()
            var dict:NSDictionary=["email":req.get_student(),"Room":req.get_room(),"Status":req.get_status()]
            var flag = false
            db.GeneratePostString(dict:dict)
            if(isInternetAvailable()==true){
            db.GetRequest(url: "http://onetouch.16mb.com/room_manage/requestroom.php")
            DispatchQueue.global(qos: .userInteractive).async {
                flag=db.CreateTask(view: self.view)
                
            }
            while(flag != true){
                
            }
            var array=(db.getjson())[0] as! [String:String]
            
                let sheet = UIAlertController.init(title: "Request sent to HMC", message: nil, preferredStyle: .alert)
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
