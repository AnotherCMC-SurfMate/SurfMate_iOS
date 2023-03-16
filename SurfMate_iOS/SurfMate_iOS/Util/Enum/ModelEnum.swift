//
//  CustomEnum.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/02/01.
//

import Foundation

enum LoginType: String, Codable {
    
    case kakao = "KAKAO"
    case google = "GOOGLE"
    case naver = "NAVER"
    case apple = "APPLE"
    case normal = "NORMAL"
    
}

enum AlertAction {
    case normal
    case goToLogin
    case next
}
