//
//  FoundationExtension.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/01/19.
//

import Foundation

extension Decodable {
    
    static func decode<T: Decodable>(any: Any) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: any, options: [.fragmentsAllowed])
        return try JSONDecoder().decode(T.self, from: data)
    }
    
}
