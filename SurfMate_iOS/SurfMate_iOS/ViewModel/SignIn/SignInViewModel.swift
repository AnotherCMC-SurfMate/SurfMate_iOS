//
//  SignInViewModel.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/02/01.
//

import Foundation
import RxSwift
import RxCocoa

class SignInViewModel {
    
    var user = User()
    
    var input = Input()
    var output = Output()
    
    
    struct Input {
        let googleLoginObserver = PublishRelay<UIViewController>()
        let naverLoginObserver = PublishRelay<String>()
        let kakaoLoginObserver = PublishRelay<Void>()
    }
    
    struct Output {
        
    }
    
    
    init() {
        
        
    }
    
    
    
    
    
}
