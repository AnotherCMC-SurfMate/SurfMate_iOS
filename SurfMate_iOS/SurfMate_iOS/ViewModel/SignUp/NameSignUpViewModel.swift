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
    }
    
    struct Output {
        let buttonAbleRelay = BehaviorRelay<Bool>(value: false)
    }
    
    
    init(_ user: User) {
        self.user = user
        
        input.textRelay
            .subscribe(onNext: {[unowned self] value in
                
                if value.count > 1 {
                    self.user.name = value
                    output.buttonAbleRelay.accept(true)
                } else {
                    output.buttonAbleRelay.accept(false)
                }
                
            }).disposed(by: disposeBag)
        
    }
    
}
