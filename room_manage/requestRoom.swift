//
//  requestRoom.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 27/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class requestRoom: baseviewcontroller,UITextFieldDelegate{
    var stud:student = student()
    
    @IBOutlet weak var room: UITextField!
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        room.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.room.resignFirstResponder()
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait)
    }
    
    @IBAction func request1(_ sender: Any) {
        if(validateString(room.text!)){
            var isValid:Bool = true //room is valid
            //check if room is valid or not
            if(self.stud.get_room()==0){
                let sheet=UIAlertController.init(title: "Room not alloted by HMC", message: nil, preferredStyle: .alert)
                let okay=UIAlertAction.init(title: "OK", style: .default){
                    (ACTION) -> Void in
                    sheet.dismiss(animated: true, completion: nil)
                    self.view.alpha=1.0
                }
                sheet.addAction(okay)
                self.present(sheet, animated: true, completion: nil)
                self.view.alpha=0.5
            }
            
            let db=DatabaseManager()
            var dict:NSDictionary=["roomno":room.text!]
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
            db.GetRequest(url: "http://onetouch.16mb.com/room_manage/validateroom.php")
            DispatchQueue.global(qos: .userInteractive).async {
                flag=db.CreateTask(view: self.view)
                
            }
            while(flag != true){
                
            }
            let array1 = db.getjson()
            var array2=array1[array1.count-1] as! [String:String]
            if(array2["flag"]=="0"){
                let sheet = UIAlertController.init(title: "Room no. not valid", message: nil, preferredStyle: .alert)
                let okay = UIAlertAction.init(title: "OK", style: .default){
                    (ACTION) -> Void in
                    sheet.dismiss(animated: true, completion: nil)
                    self.view.alpha=1.0
                }
                sheet.addAction(okay)
                self.present(sheet, animated: true, completion: nil)
                self.view.alpha=0.5
                return
            }
            var array=(db.getjson())[0] as! [String:String]
            
            if(Int(array["capacity"]!)! == 0 || array["gender"] != self.stud.get_gender() || Int(array["Year"]!)  != self.stud.get_year() || array["Programme"] != self.stud.get_programme()){
                isValid=false
            }
            
            
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
                    let db1=DatabaseManager()
                    var dict:NSDictionary=["email":self.stud.get_email(),"Room":req.get_room(),"Status":req.get_status()]
                    var flag = false
                    db.GeneratePostString(dict:dict)
                    db.GetRequest(url: "http://onetouch.16mb.com/room_manage/requestroom.php")
                    DispatchQueue.global(qos: .userInteractive).async {
                        flag=db.CreateTask(view: self.view)
                        
                    }
                    while(flag != true){
                        
                    }
                    var json=(db.getjson())[0] as! [String:String]
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
