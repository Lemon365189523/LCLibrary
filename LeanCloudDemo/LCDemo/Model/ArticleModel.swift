//
//  ArticleModel.swift
//  LCDemo
//
//  Created by lemon on 2020/1/14.
//  Copyright © 2020 LeanCloud. All rights reserved.
//

import Foundation
import LeanCloud

class ArticleModel {
    
    var title : String
    var content : String
    var imagePath : String
    var date : String
    var name : String = ""
    var avatar : String = ""
    var id : String
    var object : LCObject
    
    init(obj: LCObject) {
        object = obj
        id = obj.objectId?.stringValue ?? ""
        title = obj.get("title")?.stringValue ?? ""
        content = obj.get("content")?.stringValue ?? ""
        
        if let file = obj.get("images") as? LCFile ,
            let urlPath = file.url?.stringValue {
            imagePath = urlPath
        }else {
            imagePath = ""
        }
        
        date = obj.get("date")?.dateValue?.description ?? ""
        
        let user = obj.get("author") as? LCUser
        print(user?.get("nickname")?.stringValue)
//        print(user?.username)
//        name = user?.username?.value ?? ""
//
//        if let file = user?.get("avatar") as? LCFile ,
//            let urlPath = file.url?.stringValue {
//            avatar = urlPath
//        }else {
//            avatar = ""
//        }
//        print(user?.authData)
        
    }
}
