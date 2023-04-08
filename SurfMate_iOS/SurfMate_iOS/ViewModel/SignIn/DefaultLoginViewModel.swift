//
//  DefaultLoginViewModel.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/04/04.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class DefaultLoginViewModel {
    
    let input = Input()
    let output = Output()
    private let signInAPI = MoyaProvider<SignInAPI>()
    private let disposeBag = DisposeBag()
    
    struct Input {
        let phNumRelay = PublishRelay<String>()
        let pwValueRelay = PublishRelay<String>()
    }
    
    
    struct Output {
        let phNumFormat = PublishRelay<Bool>()
        let pwFormat = PublishRelay<Bool>()
        let loginAble = PublishRelay<Bool>()
        let errorValue = PublishRelay<SurfMateError>()
        let successValue = PublishRelay<String?>()
    }
    
    
    init() {
        
        input.phNumRelay
            .map { $0.count >= 11}
            .subscribe(onNext: {[unowned self] value in
                output.phNumFormat.accept(value)
            }).disposed(by: disposeBag)
        
        input.pwValueRelay
            .map { $0.validpassword() }
            .subscribe(onNext: { [unowned self] value in
                output.pwFormat.accept(value)
            }).disposed(by: disposeBag)
        
        PublishRelay.combineLatest(output.pwFormat, output.phNumFormat)
            .map { $0 && $1 }
            .subscribe(onNext: {[unowned self] value in
                output.loginAble.accept(value)
            }).disposed(by: disposeBag)
        
    }
    
}
