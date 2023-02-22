//
//  FoundationExtension.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/01/19.
//

import Foundation
import RxSwift


protocol DefaultViewDelegate {
    
    var disposeBag:DisposeBag { get }
    
    func setUI()
    func bind()
    
    func bindInput()
    
    func bindOutput()
    
    
    
}

extension DefaultViewDelegate {
    func bind() {
        bindInput()
        bindOutput()
    }
    
    var disposeBag:DisposeBag {
        return DisposeBag()
    }
}
