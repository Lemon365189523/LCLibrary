//
//  User.swift
//  LCDemo
//
//  Created by chuda on 2019/11/20.
//  Copyright © 2019 LeanCloud. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import LeanCloud

extension DefaultsKeys {
    static let tokenKey = DefaultsKey<String>("user_token", defaultValue: "")
}


class User {
    
    static let current = User()
    
    var token : String {
        get {
            return Defaults[.tokenKey]
        }
        set {
            Defaults[.tokenKey] = newValue
        }
    }
    
    var avatar : UIImage? {
        guard let file = info?.get("avatar") as? LCFile ,
            let urlPath = file.url?.stringValue ,
            let url = URL(string: urlPath),
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data)else {
            return nil
        }
        return image
    }
    
    var name : String {
        return info?.username?.value ?? ""
    }
    
    var signature  : String {
       return info?.get("signature")?.stringValue ?? ""
    }
    
    var nickname : String {
        return info?.get("nickname")?.stringValue ?? ""
    }
    
    var birthDay : Date? {
        return info?.get("birthDay")?.dateValue
    }
    
    var info : LCUser?
    

}

/*
 set("nickname", value: info.nickname)
 try user.set("birthDay", value: info.birthDay)
 */
