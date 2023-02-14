//
//  User.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/01/31.
//

import Foundation

struct User: Codable {
    
    var uid:String = ""
    
    var phNum: String = ""
    
    var password:String = ""
    
    var provider:LoginType = .normal
    
    var fcmToken: String = ""
    
    var nickname:String = ""
    
}
