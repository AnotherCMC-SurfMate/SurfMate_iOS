//
//  AgreeNTermViewModel.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/03/08.
//

import Foundation
import RxSwift
import RxCocoa

class AgreeNTermViewModel {
   
    let input = Input()
    let output = Output()
    private var agreeValues:[Bool] = [false, false, false, false, false]
    private let disposeBag = DisposeBag()
    
    struct Input {
        
        let allAgreeRelay = PublishRelay<Void>()
        let firstAgreeRelay = PublishRelay<Void>()
        let secondAgreeRelay = PublishRelay<Void>()
        let thirdAgreeRelay = PublishRelay<Void>()
        let forthAgreeRelay = PublishRelay<Void>()
        let fithAgreeRelay = PublishRelay<Void>()
        
    }
    
    struct Output {
        
        let agreeDriver = BehaviorRelay<[Bool]>(value: [false, false, false, false, false])
        
    }
    
    init() {
        
        input.allAgreeRelay
            .subscribe(onNext: { [unowned self] in
                
                if agreeValues == [true, true, true, true, true] {
                    agreeValues = [false, false, false, false, false]
                } else {
                    agreeValues = [true, true, true, true, true]
                }
                output.agreeDriver.accept(agreeValues)
                
            }).disposed(by: disposeBag)
        
        input.firstAgreeRelay
            .subscribe(onNext: { [unowned self] in
                
                agreeValues[0].toggle()
                output.agreeDriver.accept(agreeValues)
                
            }).disposed(by: disposeBag)
        
        input.secondAgreeRelay
            .subscribe(onNext: { [unowned self] in
                
                agreeValues[1].toggle()
                output.agreeDriver.accept(agreeValues)
                
            }).disposed(by: disposeBag)
        
        input.thirdAgreeRelay
            .subscribe(onNext: { [unowned self] in
                
                agreeValues[2].toggle()
                output.agreeDriver.accept(agreeValues)
                
            }).disposed(by: disposeBag)
        
        input.forthAgreeRelay
            .subscribe(onNext: { [unowned self] in
                
                agreeValues[3].toggle()
                output.agreeDriver.accept(agreeValues)
                
            }).disposed(by: disposeBag)
        
        input.fithAgreeRelay
            .subscribe(onNext: { [unowned self] in
                
                agreeValues[4].toggle()
                output.agreeDriver.accept(agreeValues)
                
            }).disposed(by: disposeBag)
        
    }
    
    
    
}
