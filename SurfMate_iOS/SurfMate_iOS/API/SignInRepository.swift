//
//  SignInRepository.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/02/13.
//

import Foundation
import Moya
import RxSwift

enum SignInAPI {
    case login(user: User)
    case socialLogin(user: User, token: String)
    case checkAcount(num: String)
    
}

extension SignInAPI:TargetType {
    var baseURL: URL {
        return URL(string: "https://surfmate.life")!
    }
    
    var path: String {
        switch self {
        case .login(_):
            return "/auth/login"
        case .socialLogin(_, _):
            return "/auth/social"
        case .checkAcount(_):
            return "/auth/check/account"
        
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        
        switch self {
        case .login(let user):
            let parameters:[String:Any] = ["phNum": user.phNum,
                                           "password": user.password,
                                           "fcmToken": user.fcmToken]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .socialLogin(let user, let token):
            let parameters:[String:Any] = ["accessToken": token,
                                           "provider": user.provider.rawValue,
                                           "fcmToken": user.fcmToken]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .checkAcount(let num):
            let parameters:[String:Any] = ["phNum": num]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        
        }
       
    }
    
    var headers: [String : String]? {
        return ["Connection":"keep-alive",
                "Content-Type": "application/json"]
        
    }
    
    
}

