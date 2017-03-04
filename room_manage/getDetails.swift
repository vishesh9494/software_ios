//
//  getDetails.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 27/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class getDetails: baseviewcontroller{
    var stud:student = student()
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var roll: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var programme: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var room: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text=stud.get_name()
        roll.text=stud.get_roll()
        gender.text=stud.get_gender()
        programme.text=stud.get_programme()
        year.text=String(stud.get_year())
        mobile.text=stud.get_mobile()
        room.text=String(stud.get_room())
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
