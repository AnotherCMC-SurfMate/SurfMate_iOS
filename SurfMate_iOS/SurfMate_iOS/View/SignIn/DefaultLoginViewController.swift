//
//  DefaultLoginViewController.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/02/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import TextFieldEffects

class DefaultLoginViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    let backBT = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "back_bt"), for: .normal)
        $0.isEnabled = true
    }
    
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let contentView = UIView()
    
    let loginLB = UILabel().then {
        $0.text = "로그인"
        $0.font = UIFont.pretendard(size: 26, family: .bold)
        $0.textColor = UIColor.black
    }
    
    let phoneNumTF = DefaultTextField(text: "전화번호", placeHolder: "").then {
        $0.textField.keyboardType = .numberPad
    }
    
    let pwTF = DefaultTextField(text: "비밀번호", placeHolder: "")
    
    let findPwBT = UIButton(type: .custom).then {
        let text = "비밀번호를 잊으셨나요?"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor(red: 0.483, green: 0.498, blue: 0.512, alpha: 1), range: NSRange(location: 0, length: text.count))
        attributedText.addAttribute(.font, value: UIFont.pretendard(size: 13, family: .bold), range: NSRange(location: 0, length: text.count))
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        $0.setAttributedTitle(attributedText, for: .normal)
    }
    
    let loginBT = SignUpButton(text: "로그인")
    
    let signUpLB = UILabel().then {
        $0.text = "계정이 없으신가요?"
        $0.textColor = UIColor(red: 0.741, green: 0.749, blue: 0.757, alpha: 1)
        $0.font = UIFont.pretendard(size: 15, family: .medium)
    }
    
    let signUpBT = UIButton(type: .custom).then {
        let text = "회원가입하기"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor(red: 0.227, green: 0.239, blue: 0.251, alpha: 1), range: NSRange(location: 0, length: text.count))
        attributedText.addAttribute(.font, value: UIFont.pretendard(size: 13, family: .bold), range: NSRange(location: 0, length: text.count))
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        $0.setAttributedTitle(attributedText, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension DefaultLoginViewController {
    
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
        
        
        contentView.addSubview(backBT)
        backBT.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(30)
            $0.width.height.equalTo(28)
        }
        
        contentView.addSubview(loginLB)
        loginLB.snp.makeConstraints {
            $0.top.equalTo(backBT.snp.bottom).offset(31)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(34)
        }
        
        contentView.addSubview(phoneNumTF)
        phoneNumTF.snp.makeConstraints {
            $0.top.equalTo(loginLB.snp.bottom).offset(64)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(60)
        }
        
        contentView.addSubview(pwTF)
        pwTF.snp.makeConstraints {
            $0.top.equalTo(phoneNumTF.snp.bottom).offset(65)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(60)
            
        }
        
        contentView.addSubview(findPwBT)
        findPwBT.snp.makeConstraints {
            $0.top.equalTo(pwTF.snp.bottom).offset(77)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(loginBT)
        loginBT.snp.makeConstraints {
            $0.top.equalTo(findPwBT.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview()
        }
        
        
        
    }
    
    func bind() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {
        
        backBT.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        phoneNumTF.titleLB.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                
                self.toggleTextField(self.phoneNumTF)
            }).disposed(by: disposeBag)
        
        pwTF.titleLB.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.toggleTextField(self.pwTF)
            }).disposed(by: disposeBag)
        
    }
    
    func bindOutput() {
        
    }
    
    func toggleTextField(_ textField: DefaultTextField) {
        
    }
    
}
