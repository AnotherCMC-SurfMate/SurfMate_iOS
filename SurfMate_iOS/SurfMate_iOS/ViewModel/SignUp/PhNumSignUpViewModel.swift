//
//  PhNumSignUpViewModel.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/03/15.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class PhNumSignUpViewModel {
    
    var user:User
    let input = Input()
    let output = Output()
    let signUpAPI = MoyaProvider<SignUpAPI>()
    private let disposeBag = DisposeBag()
    
    
    struct Input {
        let phNumRelay = PublishRelay<String>()
        let nextRelay = PublishRelay<String>()
    }
    
    
    struct Output {
        let buttonAble = PublishRelay<Bool>()
        let errorValue = PublishRelay<SurfMateError>()
        let successValue = PublishRelay<String?>()
    }
    
    
    init(_ user: User) {
        self.user = user
        
        input.phNumRelay
            .map { $0.count >= 11}
            .subscribe(onNext: {[unowned self] value in
                output.buttonAble.accept(value)
            }).disposed(by: disposeBag)
        
        input.nextRelay
            .flatMap(checkAccount)
            .subscribe({[unowned self] event in
                switch event {
                case .next(let result):
                    if let error = result.error {
                        output.errorValue.accept(error)
                    }
                    
                    if let value = result.value as? [String:Any] {
                        if let provider = value["provider"] as? String {
                            output.successValue.accept(provider)
                        } else {
                            output.successValue.accept(nil)
                        }
                    }
                    
                default:
                    break
                }
            }).disposed(by: disposeBag)
        
    }
    
    func checkAccount(_ num: String) -> Observable<Result> {
        user.phNum = num
        return Observable.create { observer in
            
            var value = Result()
            
            if num.count > 11 {
                
                let error = SurfMateError(0, "올바른 전화번호를\n입력해주세요.")
                value.error = error
                observer.onNext(value)
                
            } else {
                self.signUpAPI.request(.checkAcount(num: num)) { result in
                    switch result {
                    case .success(let response):
                        
                        let decoder = JSONDecoder()
                        
                        if let data = try? decoder.decode(DataResponse.self, from: response.data) {
                            
                            if data.message == "성공" {
                                
                                value.value = data.data
                                
                            } else {
                                let error = SurfMateError(data.code, data.message)
                                value.error = error
                            }
                        } else {
                            value.error = SurfMateError.SystemError
                        }
                        observer.onNext(value)
                    case .failure(_):
                        value.error = SurfMateError.NetworkError
                        observer.onNext(value)
                    }
                }
            }
            
            return Disposables.create()
        }
        
    }
    
    
}
