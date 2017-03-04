//
//  hmc.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 21/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class hmc : user{
    func set_email()->Void{
        change_email(em: "hmc@iitj.ac.in")
    }
    func set_password()->Void{
        change_password(pass: "hmciitjodhpur")
    }
    public func view_request()->Void{
        //view requests
    }
    public func allot_rooms()->Void{
        //allot rooms to first year students
    }
    public func get_stud_detail(em:String) -> student{
        //check student and return its object
        var s:student!
        return s
    }
    public func generate_report()->Void{
        //generate overall report
    }
}
