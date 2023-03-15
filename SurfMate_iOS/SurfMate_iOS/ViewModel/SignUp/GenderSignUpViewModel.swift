//
//  GenderSignUpViewModel.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/03/15.
//

import Foundation
import RxSwift
import RxCocoa


class GenderSignUpViewModel {
    
    var user:User
    
    private let disposeBag = DisposeBag()
    
    let input = Input()
    let output = Output()
    
    struct Input {
        let maleRelay = PublishRelay<Void>()
        let femaleRelay = PublishRelay<Void>()
    }
    
    struct Output {
        let genderValue = PublishRelay<User>()
    }
    
    init(_ user: User) {
        self.user = user
        
        input.maleRelay
            .subscribe(onNext: {
                self.user.gender = "male"
                self.output.genderValue.accept(self.user)
            }).disposed(by: disposeBag)
        
        input.femaleRelay
            .subscribe(onNext: {
                self.user.gender = "female"
                self.output.genderValue.accept(self.user)
            }).disposed(by: disposeBag)
        
    }
    
    
}
