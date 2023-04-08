//
//  PasswordSignUpViewController.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/03/17.
//

import UIKit
import RxCocoa
import RxSwift
import RxKeyboard

class PasswordSignUpViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    private let vm:PasswordSignUpViewModel
    private let mode:PWPageMode
    
    let backBT = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "back_bt"), for: .normal)
    }
    
    lazy var pageLB = UILabel().then {
        $0.text = "6/7"
        $0.textColor = UIColor(red: 0.741, green: 0.749, blue: 0.757, alpha: 1)
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        $0.alpha = mode == .SignUp ? 1.0 : 0
    }
    
    let titleLB = UILabel().then {
        let text = "회원가입을 위한 🔒\n비밀번호를 입력해주세요!"
        let attributedText = NSMutableAttributedString.pretendard(text, .Display2, UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1))
        $0.attributedText = attributedText
        $0.numberOfLines = 2
    }
    
    let pwTF = DefaultTextField(text: "비밀번호", placeHolder: "영문, 숫자 포함 8자리 이상").then {
        $0.textField.isSecureTextEntry = true
    }
    
    let pwVisibleBT = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "pw_not_visible"), for: .normal)
    }
    
    let pwAlertLB = UILabel().then {
        $0.textColor = UIColor(red: 0.929, green: 0.008, blue: 0.176, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Regular", size: 13)
        $0.text = "영문 , 숫자 포함 8자리 이상"
        $0.alpha = 0
    }
    
    let pwConfirmTF = DefaultTextField(text: "비밀번호 확인", placeHolder: "영문, 숫자 포함 8자리 이상").then {
        $0.textField.isSecureTextEntry = true
        $0.alpha = 0
    }
    
    let pwConfirmVisibleBT = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "pw_not_visible"), for: .normal)
    }
    
    let pwConfirmAlertLB = UILabel().then {
        $0.textColor = UIColor(red: 0.929, green: 0.008, blue: 0.176, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Regular", size: 13)
        $0.text = "비밀번호를 확인해주세요"
        $0.alpha = 0
    }
    
    let nextBT = SignUpButton(text: "다음")
    
    init(_ vm: PasswordSignUpViewModel, _ mode: PWPageMode) {
        self.vm = vm
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

extension PasswordSignUpViewController: AlertSheetDelegate {
    
    func dismissAction(_ action: AlertAction) {
        switch action {
        case .goToLogin:
            self.dismiss(animated: true)
        default:
            break
        }
    }
    
    func setUI() {
        
        navigationController?.isToolbarHidden = true
        view.backgroundColor = .white
        
        safeArea.addSubview(backBT)
        backBT.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(28)
        }
        
        safeArea.addSubview(pageLB)
        pageLB.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(23)
        }
        
        safeArea.addSubview(titleLB)
        titleLB.snp.makeConstraints {
            $0.top.equalTo(backBT.snp.bottom).offset(31)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(68)
        }
        
        safeArea.addSubview(pwTF)
        pwTF.snp.makeConstraints {
            $0.top.equalTo(titleLB.snp.bottom).offset(32)
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
        
        safeArea.addSubview(pwAlertLB)
        pwAlertLB.snp.makeConstraints {
            $0.top.equalTo(pwTF.snp.bottom).offset(3)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(20)
        }
        
        safeArea.addSubview(pwConfirmTF)
        pwConfirmTF.snp.makeConstraints {
            $0.top.equalTo(pwTF.snp.bottom).offset(27)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(74)
        }
        
        pwConfirmTF.addSubview(pwConfirmVisibleBT)
        pwConfirmTF.textField.snp.remakeConstraints {
            $0.top.equalTo(pwConfirmTF.titleLB.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(18)
            $0.height.equalTo(28)
        }
        
        pwConfirmVisibleBT.snp.makeConstraints {
            $0.top.equalTo(pwConfirmTF.titleLB.snp.bottom).offset(10)
            $0.leading.greaterThanOrEqualTo(pwConfirmTF.textField.snp.trailing).offset(18)
            $0.trailing.equalToSuperview().offset(-18)
            $0.height.equalTo(22)
        }
        
        safeArea.addSubview(pwConfirmAlertLB)
        pwConfirmAlertLB.snp.makeConstraints {
            $0.top.equalTo(pwConfirmTF.snp.bottom).offset(3)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(20)
        }
        
        
        safeArea.addSubview(nextBT)
        nextBT.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-41)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(56)
        }
        
    }
    
    func bind() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {
        
        backBT.rx.tap
            .subscribe(onNext: {
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        
        pwTF.textField.rx.controlEvent([.editingChanged])
            .map { self.pwTF.textField.text ?? "" }
            .bind(to: vm.input.pwValueRelay)
            .disposed(by: disposeBag)
        
        pwTF.textField.rx.controlEvent([.editingDidEnd])
            .bind(to: vm.input.pwFormatRelay)
            .disposed(by: disposeBag)
        
        pwVisibleBT.rx.tap
            .map { self.pwTF.textField.isSecureTextEntry }
            .bind(to: vm.input.pwVisibleRelay)
            .disposed(by: disposeBag)
        
        pwConfirmVisibleBT.rx.tap
            .map { self.pwConfirmTF.textField.isSecureTextEntry }
            .bind(to: vm.input.pwConfirmVisibleRelay)
            .disposed(by: disposeBag)
        
        pwConfirmTF.textField.rx.controlEvent([.editingDidEnd])
            .map { self.pwConfirmTF.textField.text ?? "" }
            .bind(to: vm.input.pwConfirmValueRelay)
            .disposed(by: disposeBag)
        
        nextBT.rx.tap
            .map { self.mode }
            .bind(to: vm.input.nextRelay)
            .disposed(by: disposeBag)
        
        RxKeyboard.instance.visibleHeight
            .skip(1)
            .drive(onNext: { [unowned self] keyboardVisibleHeight in
                
                let offset = keyboardVisibleHeight == 0 ? -41 : -keyboardVisibleHeight
                
                nextBT.snp.updateConstraints {
                    $0.bottom.equalToSuperview().offset(offset)
                }
                
                view.layoutIfNeeded()
                
            }).disposed(by: disposeBag)
        
    }
    
    func bindOutput() {
        
        vm.output.pwVisible.asDriver(onErrorJustReturn: true)
            .drive(onNext: {[unowned self] value in
                pwTF.textField.isSecureTextEntry = value
                pwVisibleBT.setImage(UIImage(named: value ? "pw_not_visible" : "pw_visible"), for: .normal)
            }).disposed(by: disposeBag)
        
        vm.output.pwConfirmVisible.asDriver(onErrorJustReturn: true)
            .drive(onNext: {[unowned self] value in
                pwConfirmTF.textField.isSecureTextEntry = value
                pwConfirmVisibleBT.setImage(UIImage(named: value ? "pw_not_visible" : "pw_visible"), for: .normal)
            }).disposed(by: disposeBag)
        
        vm.output.pwFormat.asDriver(onErrorJustReturn: false)
            .drive(onNext: {[unowned self] value in
                
                if value {
                    pwTF.layer.borderWidth = 0
                    pwTF.layer.borderColor = nil
                    pwTF.titleLB.textColor =  UIColor.rgb(red: 123, green: 127, blue: 131)
                    pwAlertLB.alpha = 0
                    pwConfirmTF.alpha = 1
                } else {
                    pwTF.layer.borderWidth = 1
                    pwTF.layer.borderColor = UIColor.errorColor.cgColor
                    pwTF.titleLB.textColor = UIColor.errorColor
                    pwAlertLB.alpha = 1
                    pwConfirmTF.alpha = 0
                }
                
            }).disposed(by: disposeBag)
        
        vm.output.pwConfirmFormat.asDriver(onErrorJustReturn: false)
            .drive(onNext: {[unowned self] value in
                
                if value {
                    pwConfirmTF.layer.borderWidth = 0
                    pwConfirmTF.layer.borderColor = nil
                    pwConfirmTF.titleLB.textColor =  UIColor.rgb(red: 123, green: 127, blue: 131)
                    pwConfirmAlertLB.alpha = 0
                } else {
                    pwConfirmTF.layer.borderWidth = 1
                    pwConfirmTF.layer.borderColor = UIColor.errorColor.cgColor
                    pwConfirmTF.titleLB.textColor = UIColor.errorColor
                    pwConfirmAlertLB.alpha = 1
                }
                
            }).disposed(by: disposeBag)
        
        vm.output.btAble.asDriver(onErrorJustReturn: false)
            .drive(onNext: {[unowned self] value in
                nextBT.isEnabled = value
            }).disposed(by: disposeBag)
        
        vm.output.nextValue.asDriver(onErrorJustReturn: User())
            .drive(onNext: { value in
                
                let vm = NicknameSignUpViewModel(value)
                let vc = NicknameSignUpViewController(vm)
                vc.modalTransitionStyle = .coverVertical
                vc.modalPresentationStyle = .fullScreen
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            }).disposed(by: disposeBag)
        
        vm.output.changePW.asDriver(onErrorJustReturn: "")
            .drive(onNext: { value in
                
                if let value {
                    let vc = AlertSheetController(header: "🧐", contents: value, alertAction: .normal)
                    vc.delegate = self
                    vc.sheetPresentationController?.detents = [
                        .custom(resolver: { context in
                            290
                        })
                    ]
                    self.present(vc, animated: true)
                } else {
                    let vc = AlertSheetController(header: "", contents: "새로운 비밀번호 설정이\n완료되었습니다.", alertAction: .goToLogin)
                    vc.delegate = self
                    vc.sheetPresentationController?.detents = [
                        .custom(resolver: { context in
                            256
                        })
                    ]
                    self.present(vc, animated: true)
                }
                
                
            }).disposed(by: disposeBag)
        
    }
    
}
