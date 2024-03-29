//
//  User.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/01/31.
//

import Foundation

struct User: Codable {
    
    static var loginedUser:User?
    
    var username:String = ""
    var uid:String = ""
    var phNum: String = ""
    var password:String = ""
    var provider:LoginType = .normal
    var fcmToken: String = ""
    var nickname:String = ""
    var birthDay:String = ""
    var gender:String = ""
    
    
    func clear() {
        User.loginedUser = User()
    }
}
