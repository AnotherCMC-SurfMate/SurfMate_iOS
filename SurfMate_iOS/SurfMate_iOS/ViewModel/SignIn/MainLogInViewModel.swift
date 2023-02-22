//
//  SignInViewModel.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/02/01.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import GoogleSignIn
import KakaoSDKUser
import KakaoSDKAuth

class MainLogInViewModel {
    
    private let signInAPI = MoyaProvider<SignInAPI>()
    private let disposeBag = DisposeBag()
    
    var user = User()
    
    var input = Input()
    var output = Output()
    
    
    
    struct Input {
        let googleLoginObserver = PublishRelay<UIViewController>()
        let naverAppleLoginObserver = PublishRelay<(String, LoginType)>()
        let kakaoLoginObserver = PublishRelay<Void>()
    }
    
    struct Output {
        
        let outputData = PublishRelay<(Bool, User)>()
        let errorData = PublishRelay<String>()
        
    }
    
    
    init() {
        
        input.googleLoginObserver
            .flatMap(googleLogin)
            .subscribe(onNext: { result in
                if let error = result.error {
                    self.output.errorData.accept(error.message)
                } else if let token = result.value as? (Bool, User) {
                    self.output.outputData.accept(token)
                }
            }).disposed(by: disposeBag)
        
        input.kakaoLoginObserver
            .flatMap(kakaoLogin)
            .subscribe(onNext: { result in
                if let error = result.error {
                    self.output.errorData.accept(error.message)
                } else if let token = result.value as? (Bool, User) {
                    self.output.outputData.accept(token)
                }
            }).disposed(by: disposeBag)
        
        input.naverAppleLoginObserver
            .flatMap { self.checkUser(token: $0.0, type: $0.1) }
            .subscribe(onNext: { result in
                
                if let error = result.error {
                    self.output.errorData.accept(error.message)
                } else if let token = result.value as? (Bool, User) {
                    self.output.outputData.accept(token)
                }
                
            }).disposed(by: disposeBag)
        
    }
    
    /**
     구글로 로그인 할 때 실행
     >회원가입 유무 확인 후 회원가입 페이지 or 메인화면으로 이동
     - Parameters:
     - vc: UIViewController
     - Throws: MellyError
     - Returns:User
     */
    func googleLogin(_ vc: UIViewController) -> Observable<Result> {
        
        
        return Observable.create { observer in
            
            var result = Result()
            
            GIDSignIn.sharedInstance.signIn(withPresenting: vc) { user, error in
                if let error = error {
                    let surfmateError = SurfMateError(2, error.localizedDescription)
                    result.error = surfmateError
                    observer.onNext(result)
                }
                
                if  let auth = user?.user,
                    let userToken = auth.idToken?.tokenString {
                    self.checkUser(token: userToken, type: .google)
                        .subscribe(onNext: { result in
                            observer.onNext(result)
                        }).disposed(by: self.disposeBag)
                }
            }
            
            return Disposables.create()
        }
    }
    
    
    /**
     카카오로 로그인 할 때 실행
     >회원가입 유무 확인 후 회원가입 페이지 or 메인화면으로 이동
     - Parameters:None
     - Throws: MellyError
     - Returns:User
     */
    func kakaoLogin() -> Observable<Result> {
        
        return Observable.create { observer in
            var result = Result()
            if UserApi.isKakaoTalkLoginAvailable() {
                
                UserApi.shared.loginWithKakaoTalk { token, error in
                    if let _ = error {
                        let surfMateError = SurfMateError.NetworkError
                        result.error = surfMateError
                        observer.onNext(result)
                    }
                    
                    if let token = token {
                        self.checkUser(token: token.accessToken, type: LoginType.kakao)
                            .subscribe(onNext: { result in
                                observer.onNext(result)
                            }).disposed(by: self.disposeBag)
                    }
                }
                
            } else {
                
                UserApi.shared.loginWithKakaoAccount { token, error in
                    if let _ = error {
                        let surfMateError = SurfMateError.NetworkError
                        result.error = surfMateError
                        observer.onNext(result)
                    }
                    
                    if let token = token {
                        self.checkUser(token: token.accessToken, type: LoginType.kakao)
                            .subscribe(onNext: { result in
                                observer.onNext(result)
                            }).disposed(by: self.disposeBag)
                    }
                    
                }
                
            }
            
            return Disposables.create()
        }
        
    }
    
    
    /**
     회원가입 유무 확인 후 회원가입 페이지 or 메인화면으로 이동
     - Parameters:
     - token : String
     - type: LoginType
     - Returns: (User? SurfMateError?)
     */
    func checkUser(token: String, type: LoginType) -> Observable<Result> {
        
        return Observable.create { observer in
            
            self.user.provider = type
            self.user.fcmToken = UserDefaults.standard.string(forKey: "fcmToken") ?? ""
            var result = Result()
            
            self.signInAPI.request(.socialLogin(user: self.user, token: token)) { response in
                switch response {
                case .failure(_):
                    result.error = SurfMateError.NetworkError
                    observer.onNext(result)
                case .success(let data):
                    
                    let decoder = JSONDecoder()
                    
                    if let inputData = try? decoder.decode(DataResponse.self, from: data.data) {
                        
                        if inputData.message == "성공" {
                            
                            if let _ = inputData.data?["isNewUser"] as? Bool {
                                
                            } else {
                                
                            }
                            
                        } else {
                            
                            let error = SurfMateError(inputData.code, inputData.message)
                            result.error = error
                            observer.onNext(result)
                            
                        }
                        
                    } else {
                        
                        result.error = SurfMateError.SystemError
                        
                        observer.onNext(result)
                        
                    }
                }
            }
            
            return Disposables.create()
        }
        
    }
    
    
    
    
}
