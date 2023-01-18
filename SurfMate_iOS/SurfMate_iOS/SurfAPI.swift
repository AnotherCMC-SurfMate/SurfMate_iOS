//
//  SurfAPI.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/01/16.
//

import Foundation
import Moya

enum HealthAPI {
    case getData(String, String)
}

extension HealthAPI:TargetType {
    var baseURL: URL {
        return URL(string: "https:///surfmate.life")!
    }
    
    var path: String {
        return "/health"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        <#code#>
    }
    
}
