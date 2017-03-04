//
//  request.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 21/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class request{
    private var req_student:String!
    private var req_room:Int!
    private var status:String!
    
    public func set_student(EmailID:String){
        req_student = EmailID
    }
    public func get_student() -> String{
        return req_student
    }
    public func set_room(rm:Int){
        req_room = rm
    }
    public func get_room() -> String{
        return String(req_room)
    }
    public func set_status(st: String){
        status = st
    }
    public func get_status() -> String{
        return status
    }
    /*public func get_student_name() -> String{
        return req_student.get_name()
    }*/
}
