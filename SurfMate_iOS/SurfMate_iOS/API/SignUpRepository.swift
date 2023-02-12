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
    case checkAcount(num: String)
    case checkNickname(name: String)
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
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        
        switch self {
        case .checkNickname(let name):
            let parameters:[String:Any] = ["nickname":name]
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .checkAcount(let num):
            let parameters:[String:Any] = ["phNum": num]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
       
    }
    
    var headers: [String : String]? {
        switch self {
        case .checkAcount(_):
            return ["Connection":"keep-alive",
                    "Content-Type": "application/json"]
        case .checkNickname(_):
            return ["Connection":"keep-alive",
                    "Content-Type": "application/json"]
        }
    }
    
    
}

