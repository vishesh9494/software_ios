//
//  viewRequests.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 27/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class viewRequests: baseviewcontroller,UITableViewDataSource,UITableViewDelegate{
    
    var array = [request]()
    //store requests to this array from below function
    func storeRequests(){
        //store all requests from database to this array
        
        let db=DatabaseManager()
        var dict:NSDictionary=[:]
        var flag = false
        db.GeneratePostString(dict:dict)
        db.GetRequest(url: "http://onetouch.16mb.com/room_manage/viewrequests.php")
        DispatchQueue.global(qos: .userInteractive).async {
            flag=db.CreateTask(view: self.view)
            
        }
        while(flag != true){
            
        }
        var json=(db.getjson())
        
        if(json.count != 0){
            for i in 0 ... json.count-1{
                var req:request=request()
                req.set_student(EmailID: (json[i] as! [String:String])["EmailID"]!)
                req.set_room(rm: Int((json[i] as! [String:String])["room"]!)!)
                req.set_status(st: (json[i] as! [String:String])["Status"]!)
                self.array.append(req)
            }
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tbl.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customCell
        cell.studName.text = (array[indexPath.row]).get_student()
        cell.reqRoom.text = array[indexPath.row].get_room()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sheet = UIAlertController.init(title: "Select Option", message: nil, preferredStyle: .alert)
        let accept = UIAlertAction.init(title: "Accept", style: .default){
            (ACTION) -> Void in
            //accept the request and update in database
            
            let db=DatabaseManager()
            var dict:NSDictionary=["accept":1,"EmailID":self.array[indexPath.row].get_student(),"room":self.array[indexPath.row].get_room()]
            var flag = false
            db.GeneratePostString(dict:dict)
            if(self.isInternetAvailable()==true){
            db.GetRequest(url: "http://onetouch.16mb.com/room_manage/acceptrequest.php")
            DispatchQueue.global(qos: .userInteractive).async {
                flag=db.CreateTask(view: self.view)
                
            }
            while(flag != true){
                
            }
            
            self.array.remove(at: indexPath.row)
            self.tbl.reloadData()
            sheet.dismiss(animated: true, completion: nil)
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
        let decline = UIAlertAction.init(title: "Decline", style: .default){
            (ACTION) -> Void in
            //decline the request and update in database
            
            let db=DatabaseManager()
            var dict:NSDictionary=["accept":0]
            var flag = false
            db.GeneratePostString(dict:dict)
            if(self.isInternetAvailable()==true){
            db.GetRequest(url: "http://onetouch.16mb.com/room_manage/acceptrequest.php")
            DispatchQueue.global(qos: .userInteractive).async {
                flag=db.CreateTask(view: self.view)
                
            }
            while(flag != true){
                
            }
            
            self.array.remove(at: indexPath.row)
            self.tbl.reloadData()
            sheet.dismiss(animated: true, completion: nil)
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
        let can = UIAlertAction.init(title: "Cancel", style: .destructive){
            (ACTION) -> Void in
            sheet.dismiss(animated: true, completion: nil)
            self.tbl.deselectRow(at: indexPath, animated: false)
        }
        sheet.addAction(accept)
        sheet.addAction(decline)
        sheet.addAction(can)
        self.present(sheet, animated: true, completion: nil)
    }
    
    @IBOutlet weak var tbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.delegate=self
        tbl.dataSource=self
        tbl.tableFooterView = UIView()
        storeRequests()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tbl.reloadData()
        AppUtility.lockOrientation(.portrait)
    }
    
    @IBAction func acceptAll(_ sender: Any) {
        //accept all requests from the array
        
        let db=DatabaseManager()
        var dict:NSDictionary=["accept":1]
        var flag = false
        db.GeneratePostString(dict:dict)
        if(isInternetAvailable()==true){
        db.GetRequest(url: "http://onetouch.16mb.com/room_manage/acceptall.php")
        DispatchQueue.global(qos: .userInteractive).async {
            flag=db.CreateTask(view: self.view)
            
        }
        while(flag != true){
            
        }
        
        array.removeAll()
        self.tbl.reloadData()
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
    
    @IBAction func declineAll(_ sender: Any) {
        //decline all requests from the array
        
        let db=DatabaseManager()
        var dict:NSDictionary=["accept":0]
        var flag = false
        db.GeneratePostString(dict:dict)
        if(isInternetAvailable()==true){
        db.GetRequest(url: "http://onetouch.16mb.com/room_manage/acceptall.php")
        DispatchQueue.global(qos: .userInteractive).async {
            flag=db.CreateTask(view: self.view)
            
        }
        while(flag != true){
            
        }
        
        array.removeAll()
        self.tbl.reloadData()
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
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
