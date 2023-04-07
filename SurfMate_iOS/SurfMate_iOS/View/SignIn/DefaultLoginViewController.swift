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
import RxKeyboard

class DefaultLoginViewController: UIViewController {

    private let disposeBag = DisposeBag()
    let vm = DefaultLoginViewModel()
    weak var delegate:MainLoginViewDelegate?
    
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
    
    let phNumTF = DefaultTextField(text: "전화번호", placeHolder: "휴대폰 번호 11자리").then {
        $0.textField.keyboardType = .numberPad
    }
    
    let phNumAlertLB = UILabel().then {
        $0.textColor = UIColor(red: 0.929, green: 0.008, blue: 0.176, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Regular", size: 13)
        $0.text = "올바른 번호를 입력해주세요."
        $0.alpha = 0
    }
    
    let pwTF = DefaultTextField(text: "비밀번호", placeHolder: "영문, 숫자 포함 8자리 이상").then {
        $0.textField.isSecureTextEntry = true
    }
    
    let pwAlertLB = UILabel().then {
        $0.textColor = UIColor(red: 0.929, green: 0.008, blue: 0.176, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Regular", size: 13)
        $0.text = "영문 , 숫자 포함 8자리 이상"
        $0.alpha = 0
    }
    
    let pwVisibleBT = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "pw_not_visible"), for: .normal)
    }
    
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
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(28)
        }
        
        contentView.addSubview(loginLB)
        loginLB.snp.makeConstraints {
            $0.top.equalTo(backBT.snp.bottom).offset(31)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(34)
        }
        
        contentView.addSubview(phNumTF)
        phNumTF.snp.makeConstraints {
            $0.top.equalTo(loginLB.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(74)
        }
        
        contentView.addSubview(phNumAlertLB)
        phNumAlertLB.snp.makeConstraints {
            $0.top.equalTo(phNumTF.snp.bottom).offset(3)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(pwTF)
        pwTF.snp.makeConstraints {
            $0.top.equalTo(phNumAlertLB.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(74)
        }
        
        pwTF.addSubview(pwVisibleBT)
        pwTF.textField.snp.remakeConstraints {
            $0.top.equalTo(pwTF.titleLB.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(18)
            $0.height.equalTo(28)
        }
        
        pwVisibleBT.snp.makeConstraints {
            $0.top.equalTo(pwTF.titleLB.snp.bottom).offset(10)
            $0.leading.equalTo(pwTF.textField.snp.trailing).offset(18)
            $0.trailing.equalToSuperview().offset(-18)
            $0.height.equalTo(22)
        }
        
        contentView.addSubview(pwAlertLB)
        pwAlertLB.snp.makeConstraints {
            $0.top.equalTo(pwTF.snp.bottom).offset(3)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(findPwBT)
        findPwBT.snp.makeConstraints {
            $0.top.equalTo(pwAlertLB.snp.bottom).offset(3)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(signUpLB)
        signUpLB.snp.makeConstraints {
            $0.top.equalTo(findPwBT.snp.bottom).offset(233)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(23)
        }
        
        
        contentView.addSubview(signUpBT)
        signUpBT.snp.makeConstraints {
            $0.top.equalTo(signUpLB.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(23)
        }
        
        contentView.addSubview(loginBT)
        loginBT.snp.makeConstraints {
            $0.top.equalTo(signUpBT.snp.bottom).offset(29)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().offset(-10)
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
        
        phNumTF.textField.rx.controlEvent([.editingChanged])
            .map { self.phNumTF.textField.text ?? "" }
            .bind(to: vm.input.phNumRelay)
            .disposed(by: disposeBag)
        
        pwTF.textField.rx.controlEvent([.editingChanged])
            .map { self.pwTF.textField.text ?? "" }
            .bind(to: vm.input.pwValueRelay)
            .disposed(by: disposeBag)
        
        pwVisibleBT.rx.tap
            .subscribe(onNext: { [unowned self] in
                pwTF.textField.isSecureTextEntry.toggle()
            })
            .disposed(by: disposeBag)
        
        signUpBT.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true) {
                    self.delegate?.goToAgreeNTermsViewController()
                }
            }).disposed(by: disposeBag)
        
        RxKeyboard.instance.visibleHeight
            .skip(1)
            .drive(onNext: { [unowned self] keyboardVisibleHeight in
                
                if keyboardVisibleHeight == 0 {
                    loginBT.snp.updateConstraints {
                        $0.top.equalTo(signUpBT.snp.bottom).offset(29)
                        $0.bottom.equalToSuperview().offset(-10)
                    }
                } else {
                    loginBT.snp.updateConstraints {
                        $0.top.equalTo(findPwBT.snp.bottom).offset(29)
                        $0.bottom.equalToSuperview().offset(-10 - keyboardVisibleHeight)
                    }
                }
                
                view.layoutIfNeeded()
                
            }).disposed(by: disposeBag)
        
        findPwBT.rx.tap
            .subscribe(onNext: {
                let vm = PhNumSignUpViewModel(User())
                let vc = PhNumSignUpViewController(vm, .Change)
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }).disposed(by: disposeBag)
        
    }
    
    func bindOutput() {
        
        vm.output.phNumFormat.asDriver(onErrorJustReturn: false)
            .drive(onNext: {[unowned self] value in
                
                if value {
                    phNumTF.layer.borderWidth = 0
                    phNumTF.layer.borderColor = nil
                    phNumTF.titleLB.textColor =  UIColor.rgb(red: 123, green: 127, blue: 131)
                    phNumAlertLB.alpha = 0
                } else {
                    phNumTF.layer.borderWidth = 1
                    phNumTF.layer.borderColor = UIColor.errorColor.cgColor
                    phNumTF.titleLB.textColor = UIColor.errorColor
                    phNumAlertLB.alpha = 1
                }
                
            }).disposed(by: disposeBag)
        
        vm.output.pwFormat.asDriver(onErrorJustReturn: false)
            .drive(onNext: {[unowned self] value in
                
                if value {
                    pwTF.layer.borderWidth = 0
                    pwTF.layer.borderColor = nil
                    pwTF.titleLB.textColor =  UIColor.rgb(red: 123, green: 127, blue: 131)
                    pwAlertLB.alpha = 0
                } else {
                    pwTF.layer.borderWidth = 1
                    pwTF.layer.borderColor = UIColor.errorColor.cgColor
                    pwTF.titleLB.textColor = UIColor.errorColor
                    pwAlertLB.alpha = 1
                }
                
            }).disposed(by: disposeBag)
        
        vm.output.loginAble.asDriver(onErrorJustReturn: false)
            .drive(onNext: { [unowned self] value in
                loginBT.isEnabled = value
            }).disposed(by: disposeBag)
        
    }
    
    
}
