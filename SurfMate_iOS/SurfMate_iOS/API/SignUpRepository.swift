//
//  SignUpRepository.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/01/31.
//

import Foundation
import Moya
import RxSwift

enum SignUpAPI {
    //핸드폰 번호확인
    case checkAcount(num: String)
    //닉네임 중복확인
    case checkNickname(name: String)
    //비밀번호 변경
    case passwordChange(phNum: String, newPassword: String)
    //회원가입
    case signup(user: User)
}

extension SignUpAPI:TargetType {
    
    var baseURL: URL {
        return URL(string: "https://surfmate.life")!
    }
    
    var path: String {
        switch self {
        case .checkAcount(_):
            return "/auth/check/account"
        case .checkNickname(_):
            return "/auth/check/nickname"
        case .signup(_):
            return "/auth/signup"
        case .passwordChange(_, _):
            return "/auth/password/change"
        }
    }
    
    var method: Moya.Method {
        
        switch self {
        case .passwordChange(_, _):
            return .put
        default:
            return .post
        }
        
    }
    
    
    
    var task: Moya.Task {
        
        switch self {
        case .checkNickname(let name):
            let parameters:[String:Any] = ["nickname":name]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .checkAcount(let num):
            let parameters:[String:Any] = ["phNum": num]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .signup(let user):
            if user.provider == .normal {
                let parameters:[String:Any] = ["phNum": user.phNum,
                                               "nickname":user.nickname,
                                               "password":user.password,
                                               "fcmToken":user.fcmToken,
                                               "gender":user.gender,
                                               "birthDay":user.birthDay,
                                               "username":user.username]
                return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
                
            } else {
                let parameters:[String:Any] = ["phNum": user.phNum,
                                               "nickname":user.nickname,
                                               "password":"",
                                               "fcmToken":user.fcmToken,
                                               "gender":user.gender,
                                               "birthDay":user.birthDay,
                                               "username":user.username]
                return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
                
            }
        case .passwordChange(let phNum, let newPassword):
            let parameters:[String:Any] = ["phNum": phNum,
                                           "newPassword": newPassword]
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
       
    }
    
    
    
    var headers: [String : String]? {
        
        return ["Connection":"keep-alive",
                "Content-Type": "application/json"]
    }
    
    
}

