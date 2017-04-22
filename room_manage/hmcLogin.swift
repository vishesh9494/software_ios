//
//  hmcLogin.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 27/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class hmcLogin: baseviewcontroller{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func view_req(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "viewRequests")
        self.present(vc!, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait)
    }
    
    @IBAction func allot_rooms(_ sender: Any) {
        
        let db=DatabaseManager()
        var dict:NSDictionary=[:]
        var flag = false
        db.GeneratePostString(dict:dict)
        if(isInternetAvailable()==true){
        db.GetRequest(url: "http://onetouch.16mb.com/room_manage/allotrooms.php")
        DispatchQueue.global(qos: .userInteractive).async {
            flag=db.CreateTask(view: self.view)
            
        }
        while(flag != true){
            
        }
        var json=(db.getjson())[0] as! [String:String]
            if(json["flag"]=="1"){
                let sheet=UIAlertController.init(title: "No new rooms to allot", message: nil, preferredStyle: .alert)
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
        let sheet = UIAlertController.init(title: "Rooms Allotted", message: nil, preferredStyle: .alert)
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
    
    @IBAction func get_stud(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "getStudDetails")
        self.present(vc!, animated: true, completion: nil)
    }
    @IBAction func logout(_ sender: Any) {
        let sheet = UIAlertController.init(title: "Are you sure?", message: nil, preferredStyle: .alert)
        let okay = UIAlertAction.init(title: "Yes", style: .default){
            (ACTION) -> Void in
            sheet.dismiss(animated: true, completion: nil)
            self.view.alpha=1.0
            self.dismiss(animated: true, completion: nil)
        }
        let no = UIAlertAction.init(title: "No", style: .destructive){
            (ACTION) -> Void in
            sheet.dismiss(animated: true, completion: nil)
            self.view.alpha=1.0
        }
        sheet.addAction(okay)
        sheet.addAction(no)
        self.present(sheet, animated: true, completion: nil)
        self.view.alpha=0.5
    }
}
