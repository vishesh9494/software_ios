//
//  baseviewcontroller.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 22/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

class baseviewcontroller: UIViewController{
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
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
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailRegEx1 = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let emailTest1 = NSPredicate(format:"SELF MATCHES %@", emailRegEx1)
        return emailTest.evaluate(with: testStr) || emailTest1.evaluate(with: testStr)
    }
    func isValidMobile(testStr:String) -> Bool{
        let PHONE_REGEX = "[1-9]+\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: testStr)
        return result
    }
}







