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
    
    @IBAction func allot_rooms(_ sender: Any) {
        
        
        var request1 = URLRequest(url: URL(string: "http://onetouch.16mb.com/room_manage/allotrooms.php")!)
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

        
        
        let sheet = UIAlertController.init(title: "Rooms Alloted", message: nil, preferredStyle: .alert)
        let okay = UIAlertAction.init(title: "OK", style: .default){
            (ACTION) -> Void in
            sheet.dismiss(animated: true, completion: nil)
            self.view.alpha=1.0
        }
        sheet.addAction(okay)
        self.present(sheet, animated: true, completion: nil)
        self.view.alpha=0.5
    }
    
    @IBAction func get_stud(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "getStudDetails")
        self.present(vc!, animated: true, completion: nil)
    }
    @IBAction func logout(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
