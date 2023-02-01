//
//  SurfAPI.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/01/16.
//

import Foundation
import Moya
import RxSwift

enum HealthAPI {
    case health
}

extension HealthAPI:TargetType {
    var baseURL: URL {
        return URL(string: "https://surfmate.life")!
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
        return ["Content-Type": "application/json"]
    }
    
}

final class HealthRepository: BaseRepository<HealthAPI> {
    
    static let shared = HealthRepository()
    
    private override init() {}
    
    func healthCheck(_ completion: @escaping (Result) -> Void) {
        rx.request(.health)
            .filterSuccessfulStatusCodes()
            .subscribe { event in
                switch event {
                case .success(let response):
                    
                    let decoder = JSONDecoder()
                    
                    if let json = try? decoder.decode(DataResponse.self, from: response.data) {
                        print(json)
                    }
                    
                case .failure(_):
                    var result = Result()
                    result.error = SurfMateError()
                    completion(result)
                }
            }
            .disposed(by: disposeBag)
    }
    
    
    
}
