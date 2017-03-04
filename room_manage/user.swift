//
//  user.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 21/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation

class user {
    private var email:String = ""
    private var password:String = ""
    public func change_email (em:String) -> Void {
        email=em
    }
    public func get_email () -> String {
        return email
    }
    public func change_password (pass:String) -> Void {
        password=pass
    }
    public func get_password()-> String{
        return password
    }
}
