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
        let tapButton = PublishRelay<String?>()
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
            .flatMap(signUp)
            .subscribe(onNext: { [unowned self] value in
                
                if let error = value.error {
                    output.tapButton.accept(error.message)
                } else {
                    User.loginedUser = self.user
                    output.tapButton.accept(nil)
                }
            }).disposed(by: disposeBag)
        
    }
    
    /**
     닉네임 체크 함수
        -2글자 이상인지 확인
        -중복된 닉네임이 있는지 API 통신
     - Parameters:
        - name(String): 닉네임
     - Throws: MellyError
     - Returns:String
     */
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
    
    /**
     회원가입 API 실행
     - Parameters:None
     - Throws: MellyError
     - Returns:??
     */
    func signUp() -> Observable<Result> {
        
        return Observable.create { observer in
            var responseOutput = Result()
            self.signUpAPI.request(.signup(user: self.user)) { result in
                switch result {
                case .success(let response):
                    let jsonDecoder = JSONDecoder()
                    if let data = try? jsonDecoder.decode(DataResponse.self, from: response.data) {
                        if data.message == "성공" {
                            observer.onNext(responseOutput)
                        } else {
                            let error = SurfMateError(data.code, data.message)
                            responseOutput.error = error
                            observer.onNext(responseOutput)
                        }
                    }
                case .failure(_):
                    let error = SurfMateError.SystemError
                    responseOutput.error = error
                    observer.onNext(responseOutput)
                }
            }
            
            return Disposables.create()
        }
        
        
    }
    
    
    
}
