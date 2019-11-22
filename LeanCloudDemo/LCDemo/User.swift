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
    
    var info : LCUser?
}
