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
    let data: [String:Any]?
 
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.code = (try? values.decode(Int.self, forKey: .code)) ?? 0
        self.message = (try? values.decode(String.self, forKey: .message)) ?? "관리자에게 문의해주세요."
        self.data = (try? values.decode([String:Any].self, forKey: .data))

    }
    
    enum CodingKeys: CodingKey {
        case code
        case message
        case data
    }
    
}

struct SurfMateError {
    
    static let NetworkError = SurfMateError(1, "네트워크 연결상태를 확인해주세요.")
    static let SystemError = SurfMateError(999, "관리자에게 문의해주세요")
    
    let code: Int
    let message:String
    
    init(_ code: Int, _ message: String) {
        self.code = code
        self.message = message
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

