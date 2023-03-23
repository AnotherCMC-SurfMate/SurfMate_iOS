//
//  NicknameSignUpViewModel.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/03/23.
//

import Foundation
import RxCocoa
import RxSwift
import Moya

class NicknameSignUpViewModel {
    
    private let disposeBag = DisposeBag()
    let signUpAPI = MoyaProvider<SignUpAPI>()
    var user:User
    
    let input = Input()
    let output = Output()
    
    struct Input {
        let nicknameTextRelay = PublishRelay<String>()
        let buttonRelay = PublishRelay<Void>()
        
    }
    
    struct Output {
        let buttonAble = PublishRelay<String?>()
        let tapButton = PublishRelay<User>()
    }
    
    init(_ user: User) {
        self.user = user
        
        input.nicknameTextRelay
            .flatMap(checkNickName)
            .subscribe(onNext: {[unowned self] value in
                if let error = value.error {
                    output.buttonAble.accept(error.message)
                } else if let name = value.value as? String {
                    self.user.nickname = name
                    output.buttonAble.accept(nil)
                }
            }).disposed(by: disposeBag)
        
        input.buttonRelay
            .subscribe(onNext: {
                self.output.tapButton.accept(self.user)
            }).disposed(by: disposeBag)
        
    }
    
    
    func checkNickName(_ name:String) -> Observable<Result> {
        
        var response = Result()
        
        return Observable.create { observer in
            
            if name.count < 1 {
                
                let error = SurfMateError(999, "2글자 이상 입력해주세요.")
                response.error = error
                observer.onNext(response)
                
            } else {
                
                self.signUpAPI.request(.checkNickname(name: name)) { result in
                    
                    switch result {
                    case .failure(_):
                        let error = SurfMateError.NetworkError
                        response.error = error
                        observer.onNext(response)
                    case .success(let data):
                        
                        let jsonDecoder = JSONDecoder()
                        
                        if let data = try? jsonDecoder.decode(DataResponse.self, from: data.data) {
                            if data.message == "성공" {
                                response.value = name
                                observer.onNext(response)
                            } else {
                                let error = SurfMateError(data.code, data.message)
                                response.error = error
                                observer.onNext(response)
                            }
                        } else {
                            
                            let error = SurfMateError.SystemError
                            response.error = error
                            observer.onNext(response)
                            
                        }
                    }
                }
            }
            return Disposables.create()
        }
        
    }
    
}
