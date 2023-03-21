//
//  PasswordSignUpViewModel.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/03/17.
//

import Foundation
import RxSwift
import RxCocoa

class PasswordSignUpViewModel {
    
    private let disposeBag = DisposeBag()
    
    var user:User
    
    let input = Input()
    let output = Output()
    
    struct Input {
        let pwVisibleRelay = PublishRelay<Bool>()
        let pwValueRelay = PublishRelay<String>()
        let pwFormatRelay = PublishRelay<Void>()
        let pwConfirmValueRelay = PublishRelay<String>()
        let pwConfirmVisibleRelay = PublishRelay<Bool>()
        let nextRelay = PublishRelay<Void>()
    }
    
    struct Output {
        let pwVisible = BehaviorRelay<Bool>(value: true) // 비밀번호 표시
        let pwFormat = PublishRelay<Bool>() // 영,숫자 8자리이상 확인
        let pwConfirmFormat = PublishRelay<Bool>()
        let pwConfirmVisible = BehaviorRelay<Bool>(value: true) //비밀번호 확인 표시
        let btAble = BehaviorRelay<Bool>(value: false)
        let nextValue = PublishRelay<User>()
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
            .map { self.user }
            .subscribe(onNext: {[unowned self] value in
                output.nextValue.accept(value)
            }).disposed(by: disposeBag)
        
    }
    
    
    
}
