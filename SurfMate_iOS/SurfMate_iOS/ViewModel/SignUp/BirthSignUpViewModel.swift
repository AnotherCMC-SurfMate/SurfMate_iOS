//
//  BirthSignUpViewModel.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/03/14.
//

import Foundation
import RxSwift
import RxCocoa

class BirthSignUpViewModel {
    
    var user:User
    var birth:[String] = ["", "", ""]
    let input = Input()
    let output = Output()
    
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let yearRelay = PublishRelay<String>()
        let monthRelay = PublishRelay<String>()
        let dayRelay = PublishRelay<String>()
        let nextRelay = PublishRelay<Void>()
    }
    
    struct Output {
        
        let buttonAble = BehaviorRelay<Bool>(value: false)
        let userValue = PublishRelay<User>()
        
    }
    
    init(_ user: User) {
        self.user = user
        
        input.yearRelay
            .subscribe(onNext: {[unowned self] value in
                birth[0] = value
                output.buttonAble.accept(isAble())
            }).disposed(by: disposeBag)
        
        input.monthRelay
            .subscribe(onNext: {[unowned self] value in
                birth[1] = value
                output.buttonAble.accept(isAble())
            }).disposed(by: disposeBag)
        
        input.dayRelay
            .subscribe(onNext: {[unowned self] value in
                birth[2] = value
                output.buttonAble.accept(isAble())
            }).disposed(by: disposeBag)
        
        input.nextRelay
            .subscribe(onNext: { [unowned self] in
                self.user.birth = birth.joined()
                output.userValue.accept(user)
            }).disposed(by: disposeBag)
        
    }
    
    func isAble() -> Bool {
        
        return birth[0].count == 4 && birth[1].count == 2 && birth[2].count == 2
        
    }
    
}
