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
        
        var request1 = URLRequest(url: URL(string: "http://onetouch.16mb.com/room_manage/viewrequests.php")!)
        request1.httpMethod = "POST"
        let postString:String = ""
        request1.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request1) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            do{
                let json=try JSONSerialization.jsonObject(with: data, options: .allowFragments ) as! NSArray
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
            
            var request1 = URLRequest(url: URL(string: "http://onetouch.16mb.com/room_manage/acceptrequest.php")!)
            request1.httpMethod = "POST"
            let postString:String = "accept=\(1)&EmailID=\(self.array[indexPath.row].get_student())&room=\(self.array[indexPath.row].get_room())"
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
            sleep(2);

            
            
            
            
            self.array.remove(at: indexPath.row)
            self.tbl.reloadData()
            sheet.dismiss(animated: true, completion: nil)
        }
        let decline = UIAlertAction.init(title: "Decline", style: .default){
            (ACTION) -> Void in
            //decline the request and update in database
            
            var request1 = URLRequest(url: URL(string: "http://onetouch.16mb.com/room_manage/acceptrequest.php")!)
            request1.httpMethod = "POST"
            let postString:String = "accept=\(0)"
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
            sleep(2);

            
            self.array.remove(at: indexPath.row)
            self.tbl.reloadData()
            sheet.dismiss(animated: true, completion: nil)
        }
        let can = UIAlertAction.init(title: "Cancel", style: .destructive){
            (ACTION) -> Void in
            sheet.dismiss(animated: true, completion: nil)
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
        storeRequests()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tbl.reloadData()
    }
    
    @IBAction func acceptAll(_ sender: Any) {
        //accept all requests from the array
        
        
        var request1 = URLRequest(url: URL(string: "http://onetouch.16mb.com/room_manage/acceptall.php")!)
        request1.httpMethod = "POST"
        let postString:String = "accept=\(1)"
        request1.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request1) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            do{
                
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
        sleep(2);

        
        array.removeAll()
        self.tbl.reloadData()
    }
    
    @IBAction func declineAll(_ sender: Any) {
        //decline all requests from the array
        
        var request1 = URLRequest(url: URL(string: "http://onetouch.16mb.com/room_manage/acceptall.php")!)
        request1.httpMethod = "POST"
        let postString:String = "accept=\(0)"
        request1.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request1) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            do{
                
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
        sleep(2);

        
        
        array.removeAll()
        self.tbl.reloadData()
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
