//
//  DataResponse.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/01/16.
//

import Foundation

struct DataResponse: Decodable {
    let code: Int
    let message:String
    let data: Data?
    
}

struct SurfMateError {
    
    let code: Int
    let message:String
    
    init() {
        self.code = 1
        self.message = "네트워크 연결상태를 확인해주세요."
    }
    
    init(_ data: DataResponse) {
        self.code = data.code
        self.message = data.message
    }
    
}

struct Result {
    
    var value:Any? = nil
    var error:SurfMateError? = nil
    
}

