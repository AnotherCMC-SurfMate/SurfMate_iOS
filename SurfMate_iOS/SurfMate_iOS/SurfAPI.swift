//
//  SurfAPI.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/01/16.
//

import Foundation
import Moya

enum SurfMateAPIService {
    case getData(String, String)
}

extension SurfMateAPIService:TargetType {
    var baseURL: URL {
        <#code#>
    }
    
    var path: String {
        <#code#>
    }
    
    var method: Moya.Method {
        <#code#>
    }
    
    var task: Moya.Task {
        <#code#>
    }
    
    var headers: [String : String]? {
        <#code#>
    }
    
}
