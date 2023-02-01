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
    case defaultSignUp
    case apiSignUp
}

extension SignUpAPI:TargetType {
    var baseURL: URL {
        return URL(string: "https://surfmate.life")!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}

