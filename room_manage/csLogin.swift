//
//  csLogin.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 27/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class csLogin: baseviewcontroller{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func feedData1(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "feedData")
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
