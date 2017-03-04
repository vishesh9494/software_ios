//
//  feedData.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 27/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class feedData:baseviewcontroller{
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var roll: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        name.resignFirstResponder()
        email.resignFirstResponder()
        mobile.resignFirstResponder()
        roll.resignFirstResponder()
    }
    @IBAction func submit(_ sender: Any) {
        if(validateString(name.text!) && validateString(roll.text!) && validateString(mobile.text!) && validateString(email.text!)){
            //add student to database
            let sheet = UIAlertController.init(title: "Student Added Successfully", message: nil, preferredStyle: .alert)
            let okay = UIAlertAction.init(title: "OK", style: .default){
                (ACTION) -> Void in
                sheet.dismiss(animated: true, completion: nil)
                self.name.text=""
                self.roll.text=""
                self.mobile.text=""
                self.email.text=""
                self.view.alpha=1.0
            }
            sheet.addAction(okay)
            self.present(sheet, animated: true, completion: nil)
            self.view.alpha=0.5

        }
        else{
            let sheet = UIAlertController.init(title: "Invalid Credentials", message: nil, preferredStyle: .alert)
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
