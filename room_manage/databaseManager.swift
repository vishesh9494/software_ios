//
//  databaseManager.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 23/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation

class databaseManager{
    var request = URLRequest(url: URL(string: "http://onetouch.16mb.com/room_manage/signup.php")!)
    public func generatepost(stud:student)->String{
        var str:String
        str="name=\(stud.get_name())&roll=\(stud.get_roll())&mobile=\(stud.get_mobile())&Email=\(stud.get_email())&room=\(stud.get_room())&programme=\(stud.get_programme())&year=\(stud.get_year())&gender=\(stud.get_gender())&password=\(stud.get_password())"
        return str
    }

}
