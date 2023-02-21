//
//  SignInViewModel.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/02/01.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class MainLogInViewModel {
    
    let signInAPI = MoyaProvider<SignInAPI>()
    
    var input = Input()
    var output = Output()
    
    
    struct Input {
        let googleLoginObserver = PublishRelay<UIViewController>()
        let naverLoginObserver = PublishRelay<String>()
        let kakaoLoginObserver = PublishRelay<Void>()
    }
    
    struct Output {
        
    }
    
    
    init() {
        
        
    }
    
    /**
         회원가입 유무 확인 후 회원가입 페이지 or 메인화면으로 이동
         - Parameters:
            - token : String
            - type: LoginType
         - Returns: (User? SurfMateError?)
         */
    func checkUser(token: String, type: LoginType) -> Observable<Result> {
        
        return Observable.create { observer in
            
            User.loginedUser.provider = type
            
            var result = Result()
            
            self.signInAPI.request(.socialLogin(user: User.loginedUser, token: token)) { response in
                switch response {
                case .failure(_):
                    result.error = SurfMateError()
                    observer.onNext(result)
                case .success(let data):
                    
                    let decoder = JSONDecoder()
                    if let inputData = try? decoder.decode(DataResponse.self, from: data.data) {
                        
                        if inputData.message == "성공" {
                            
                        } else {
                            
                        }
                        
                    } else {
                       
                    }
                }
            }
                
            
            
            return Disposables.create()
        }
        
        
    }
    
    
    
    
}
