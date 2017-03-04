//
//  baseviewcontroller.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 22/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class baseviewcontroller: UIViewController{
    func validateString(_ str: String)->Bool
    {
        if(str==nil){
            return false
        }
        var result : Bool?
        let str1 = str.trimmingCharacters(in: CharacterSet.whitespaces)
        let whitespace = CharacterSet.whitespacesAndNewlines
        let trimmed = str1.trimmingCharacters(in: whitespace) as NSString
        if trimmed.length > 0
        {
            result = true
        }
        else
        {
            result = false
        }
        return result!
    }
}
