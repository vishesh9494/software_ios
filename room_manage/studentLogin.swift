//
//  studentLogin.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 25/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class studentLogin: baseviewcontroller,UIAlertViewDelegate{
    
    @IBOutlet weak var roll: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var room: UILabel!
    
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var view4: UIView!
    
    var isAcademicYear:Bool! //flag for checking if it is academic year or not
    
    var stud:student = student()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assume that an object of student is available
        name.text = stud.get_name()
        roll.text = stud.get_roll()
        
        
        //check for start of academic year
        isAcademicYear = false //not start of academic year
        if(isAcademicYear==true){
            view2.isHidden = true
            view3.isHidden = false
            view4.isHidden = true
        }
        else{
            view2.isHidden = false
            view3.isHidden = false
            view4.isHidden = false
                    }
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
    
    @IBAction func requestRoom(_ sender: Any) {
        //check if previous request is pending or not
        var checkReq:Bool = false //there is previous request pending
        if(checkReq==true){
            let sheet = UIAlertController.init(title: "A previous request already exists", message: nil, preferredStyle: .alert)
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
            //if no request is pending
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "requestRoom") as! requestRoom
            vc.stud = stud
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait)
        if(String(stud.get_room()) != "0"){
            room.text = String(stud.get_room())
        }
        else{
            room.text = "Not Alloted"
        }

    }
    
    @IBAction func changeRoom(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "changeRoom") as! changeRoom
        vc.stud = stud
        self.present(vc, animated: true, completion: nil)
    }
}






