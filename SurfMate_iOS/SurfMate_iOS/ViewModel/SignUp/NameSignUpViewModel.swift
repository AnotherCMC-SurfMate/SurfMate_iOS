//
//  NameSignUpViewModel.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/03/09.
//

import Foundation
import RxSwift
import RxCocoa

class NameSignUpViewModel {
    
    var user:User
    
    let input = Input()
    let output = Output()
    private var disposeBag = DisposeBag()
    
    
    struct Input {
        let textRelay = PublishRelay<String>()
        let nextRelay = PublishRelay<Void>()
    }
    
    struct Output {
        let buttonAbleRelay = BehaviorRelay<Bool>(value: false)
        let nextValue = PublishRelay<User>()
    }
    
    
    init(_ user: User) {
        self.user = user
        
        input.textRelay
            .subscribe(onNext: {[unowned self] value in
                
                if value.count > 1 {
                    self.user.username = value
                    output.buttonAbleRelay.accept(true)
                } else {
                    output.buttonAbleRelay.accept(false)
                }
                
            }).disposed(by: disposeBag)
        
        input.nextRelay
            .subscribe(onNext: {
                self.output.nextValue.accept(self.user)
            }).disposed(by: disposeBag)
        
    }
    
}
