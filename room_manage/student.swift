//
//  student.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 21/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation

class student : user{
    private var name:String!
    private var roll:String!
    private var mobile:String!
    private var room:Int=0
    private var programme:String!
    private var year:Int!
    private var gender:String!
    
    public func get_room()-> Int{
        return room
    }
    public func set_room(rm:Int) -> Void{
        room=rm
    }
    public func request_room (rm:Int!) -> Bool{
        //check if request is accepted or declined
        return true
    }
    public func change_room (rm:Int!) -> Bool{
        //check if request is accepted or declined
        return true
    }
    public func view_alloted_room() -> Void{
        //view the allotted room
    }
    public func get_room_no() -> Int{
        return room
    }
    public func set_room_no(rm:Int!) -> Void{
        room=rm
    }
    public func get_name() -> String{
        return name
    }
    public func set_name(nm:String!) -> Void{
        name=nm
    }
    public func get_roll() -> String{
        return roll
    }
    public func set_roll(rll:String!) -> Void{
        roll=rll
    }
    public func get_mobile() -> String{
        return mobile
    }
    public func set_mobile(mob:String!) -> Void{
        mobile=mob
    }
    public func get_programme() -> String{
        return programme
    }
    public func set_programme(pg:String!) -> Void{
        programme=pg
    }
    public func get_year() -> Int{
        return year
    }
    public func set_year(yr:Int!) -> Void{
        year=yr
    }
    public func get_gender() -> String{
        return gender
    }
    public func set_gender(gend:String!) -> Void{
        gender=gend
    }
    public func set_email(em:String!) -> Void{
        change_email(em: em)
    }
    public func set_password(pass:String!) -> Void{
        change_password(pass: pass)
    }
}
