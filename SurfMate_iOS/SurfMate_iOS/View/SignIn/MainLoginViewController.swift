//
//  MainLoginViewController.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/02/14.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import NaverThirdPartyLogin
import AuthenticationServices


class MainLoginViewController: UIViewController {
    
    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    let logoImageView = UIImageView().then {
        $0.backgroundColor = .gray
    }
    
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let contentView = UIView()
    
    let loginBT = DefaultButton(text: "로그인", clearColor: false)
    
    let signUpBT = DefaultButton(text: "회원가입")
    
    let socialLabel = UILabel().then {
        $0.text = "소셜 로그인"
        $0.font = UIFont.pretendard(size: 15)
        $0.textColor = UIColor(red: 0.741, green: 0.749, blue: 0.757, alpha: 1)
    }
    
    lazy var apiFieldStack = UIStackView(arrangedSubviews: [kakaoLoginBt, naverLoginBt, googleLoginBt, appleLoginBt]).then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.distribution = .fillEqually
    }
    
    
    let googleLoginBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "googleLogo"), for: .normal)
    }
    
    let kakaoLoginBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "kakaoLogo"), for: .normal)
    }
    
    let naverLoginBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "naverLogo"), for: .normal)
    }
    
    let appleLoginBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "appleLogo"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
    }
    
    
}

extension MainLoginViewController: DefaultViewDelegate {
    
    func setUI() {
        
        view.backgroundColor = .white
        
        safeArea.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.width.centerX.top.bottom.equalToSuperview()
        }
        
        contentView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(127)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(192)
        }
        
        contentView.addSubview(loginBT)
        loginBT.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(127)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(56)
        }
        
        contentView.addSubview(signUpBT)
        signUpBT.snp.makeConstraints {
            $0.top.equalTo(loginBT.snp.bottom).offset(19)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(56)
        }
        
        contentView.addSubview(socialLabel)
        socialLabel.snp.makeConstraints {
            $0.top.equalTo(signUpBT.snp.bottom).offset(37)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(23)
        }
        
        contentView.addSubview(apiFieldStack)
        apiFieldStack.snp.makeConstraints {
            $0.top.equalTo(socialLabel.snp.bottom).offset(11)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
        }
        
    }
    
    func bind() {
        
    }
    
    
}

extension MainLoginViewController: NaverThirdPartyLoginConnectionDelegate {
    
    private func getNaverInfo() {
        guard let isValidAccessToken = naverLoginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        if !isValidAccessToken { return }
        guard let accessToken = naverLoginInstance?.accessToken else { return }
        //vm.input.naverAppleLoginObserver.accept((accessToken, LoginType.naver))
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        getNaverInfo()
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        naverLoginInstance?.requestDeleteToken()
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        showErrorAlert(msg: error.localizedDescription)
    }
    
    
}

extension MainLoginViewController: ASAuthorizationControllerDelegate {
    
    //애플로그인 실행
    func appleLogin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }
    
    //토큰을 정상적으로 발급받으면 viewmodel로 이동
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            if let token = String(data: credential.identityToken ?? Data(), encoding: .utf8) {
                //vm.input.naverAppleLoginObserver.accept((token, .apple))
            }
        }
    }
    
    //애플로그인에서 에러 발생시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        showErrorAlert(msg: error.localizedDescription)
    }
    
    
}
