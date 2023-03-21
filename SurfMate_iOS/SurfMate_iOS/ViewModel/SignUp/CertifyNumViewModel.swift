//
//  CertifyNumViewModel.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/03/16.
//

import Foundation
import RxSwift
import RxCocoa
import FirebaseAuth
class CertifyNumViewModel {
    let user: User
    private let disposeBag = DisposeBag()
    var certifyNum:String = "111111"
    let input = Input()
    let output = Output()
    
    struct Input {
        let getCertifyRelay = BehaviorRelay<Void>(value: ())
        let tfRelay = PublishRelay<String>()
        let certifyNumRelay = PublishRelay<String>()
    }
    
    struct Output {
        
        let errorValue = PublishRelay<String>()
        let ableValue = PublishRelay<Bool>()
        let confirmValue = PublishRelay<User?>()
        let resetValue = PublishRelay<Void>()
    }
    
    init(_ user: User) {
        self.user = user
        
//        input.getCertifyRelay
//            .flatMap(getCertifyNum)
//            .subscribe({[unowned self] event in
//                switch event {
//                case .next(let result):
//                    
//                    if let value = result.value as? String {
//                        certifyNum = value
//                        output.resetValue.accept(())
//                    }
//                    
//                    if let _ = result.error {
//                        //네트워크 에러 알럿창 필요
//                    }
//                    
//                default:
//                    break
//                }
//            }).disposed(by: disposeBag)
        
        input.tfRelay
            .map { $0.count == 6 }
            .subscribe(onNext: {[unowned self] value in
                output.ableValue.accept(value)
            }).disposed(by: disposeBag)
        
        input.certifyNumRelay
            .map { $0 == self.certifyNum }
            .subscribe(onNext: {[unowned self] value in
                
                if value {
                    output.confirmValue.accept(self.user)
                } else {
                    output.confirmValue.accept(nil)
                }
                
                
            }).disposed(by: disposeBag)
        
        
    }
    
    func getCertifyNum() -> Observable<Result> {
        
        return Observable.create { observer in
            var result = Result()
            PhoneAuthProvider.provider().verifyPhoneNumber("+82 \(self.user.phNum)", uiDelegate: nil) { verificationID, error in
                if let verificationID {
                    
                    result.value = verificationID
                    observer.onNext(result)
                }
                if let _ = error {
                    let error = SurfMateError.NetworkError
                    result.error = error
                    observer.onNext(result)
                }
            }
            return Disposables.create()
        }
        
    }
    
}
