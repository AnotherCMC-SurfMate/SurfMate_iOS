//
//  PasswordSignUpViewModel.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/03/17.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class PasswordSignUpViewModel {
    
    private let disposeBag = DisposeBag()
    private let signUpAPI = MoyaProvider<SignUpAPI>()
    var user:User
    
    let input = Input()
    let output = Output()
    
    struct Input {
        let pwVisibleRelay = PublishRelay<Bool>()
        let pwValueRelay = PublishRelay<String>()
        let pwFormatRelay = PublishRelay<Void>()
        let pwConfirmValueRelay = PublishRelay<String>()
        let pwConfirmVisibleRelay = PublishRelay<Bool>()
        let nextRelay = PublishRelay<PWPageMode>()
    }
    
    struct Output {
        let pwVisible = BehaviorRelay<Bool>(value: true) // 비밀번호 표시
        let pwFormat = PublishRelay<Bool>() // 영,숫자 8자리이상 확인
        let pwConfirmFormat = PublishRelay<Bool>()
        let pwConfirmVisible = BehaviorRelay<Bool>(value: true) //비밀번호 확인 표시
        let btAble = BehaviorRelay<Bool>(value: false)
        let nextValue = PublishRelay<User>()
        let changePW = PublishRelay<String?>()
    }
    
    init(_ user: User) {
        self.user = user
        
        input.pwVisibleRelay
            .subscribe(onNext: {[unowned self] value in
                output.pwVisible.accept(!value)
            }).disposed(by: disposeBag)
        
        input.pwConfirmVisibleRelay
            .subscribe(onNext: {[unowned self] value in
                output.pwConfirmVisible.accept(!value)
            }).disposed(by: disposeBag)
        
        input.pwValueRelay
            .subscribe(onNext: { value in
                self.user.password = value
            }).disposed(by: disposeBag)
        
        input.pwFormatRelay
            .map { self.user.password.validpassword() }
            .subscribe(onNext: { [unowned self] value in
                output.pwFormat.accept(value)
            }).disposed(by: disposeBag)
        
        input.pwConfirmValueRelay
            .map { $0 == self.user.password }
            .subscribe(onNext: {[unowned self] value in
                output.pwConfirmFormat.accept(value)
            }).disposed(by: disposeBag)
        
        PublishRelay.combineLatest(output.pwFormat, output.pwConfirmFormat)
            .map { $0 && $1 }
            .subscribe(onNext: {[unowned self] value in
                output.btAble.accept(value)
            }).disposed(by: disposeBag)
        
        input.nextRelay
            .subscribe(onNext: {[unowned self] mode in
                
                switch mode {
                case .SignUp:
                    output.nextValue.accept(user)
                case .Change:
                    findPW().asDriver(onErrorJustReturn: Result())
                        .drive(onNext: {[unowned self] value in
                            if let error = value.error {
                                output.changePW.accept(error.message)
                            } else {
                                output.changePW.accept(nil)
                            }
                        }).disposed(by: disposeBag)
                }
            }).disposed(by: disposeBag)
        
    }
    
    /**
     비밀번호 변경 API 통신
     - Parameters:None
     - Throws: MellyError
     - Returns:None
     */
    func findPW() -> Observable<Result> {
        
        return Observable.create {[unowned self] observer in
            var responseOutput = Result()
            signUpAPI.request(.passwordChange(phNum: user.phNum, newPassword: user.password)) { result in
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
