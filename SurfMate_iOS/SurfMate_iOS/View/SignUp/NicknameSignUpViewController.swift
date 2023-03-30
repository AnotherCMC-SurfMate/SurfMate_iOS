//
//  NicknameSignUpViewController.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/03/23.
//

import Foundation
import RxSwift
import RxCocoa
import RxKeyboard

class NicknameSignUpViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    private let vm:NicknameSignUpViewModel
    
    let backBT = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "back_bt"), for: .normal)
    }
    
    let pageLB = UILabel().then {
        $0.text = "7/7"
        $0.textColor = UIColor(red: 0.741, green: 0.749, blue: 0.757, alpha: 1)
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 15)
    }
    
    let titleLB = UILabel().then {
        let text = "타보자GO에서 어떤 🧐\n닉네임으로 불러드릴까요?"
        let attributedText = NSMutableAttributedString.pretendard(text, .Display2, UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1))
        $0.attributedText = attributedText
        $0.numberOfLines = 2
    }
    
    let nicknameTF = DefaultTextField(text: "닉네임", placeHolder: "한글 2자 이상").then {
        $0.textField.isSecureTextEntry = true
    }
    
    let nicknameAlertLB = UILabel().then {
        $0.textColor = UIColor(red: 0.929, green: 0.008, blue: 0.176, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Regular", size: 13)
        $0.text = "영문 , 숫자 포함 8자리 이상"
        $0.alpha = 0
    }
    
    
    let nextBT = SignUpButton(text: "다음")
    
    init(_ vm: NicknameSignUpViewModel) {
        self.vm = vm
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

extension NicknameSignUpViewController {
    
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
        
        safeArea.addSubview(nicknameTF)
        nicknameTF.snp.makeConstraints {
            $0.top.equalTo(titleLB.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(74)
        }
        
        safeArea.addSubview(nicknameAlertLB)
        nicknameAlertLB.snp.makeConstraints {
            $0.top.equalTo(nicknameTF.snp.bottom).offset(3)
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
        bindOuput()
    }
    
    func bindInput() {
        
        nicknameTF.textField.rx.controlEvent([.editingChanged])
            .map { self.nicknameTF.textField.text ?? "" }
            .bind(to: vm.input.nicknameTextRelay)
            .disposed(by: disposeBag)
        
        backBT.rx.tap
            .subscribe(onNext: {
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        
        nextBT.rx.tap
            .subscribe(onNext:{
                self.present(self.ApiLoadingView, animated: true) {
                    self.vm.input.buttonRelay.accept(())
                }
            })
            .disposed(by: disposeBag)
        
        RxKeyboard.instance.visibleHeight
            .skip(1)
            .drive(onNext: { [unowned self] keyboardVisibleHeight in
                
                nextBT.snp.updateConstraints {
                    $0.bottom.equalToSuperview().offset(-keyboardVisibleHeight)
                }
                
                view.layoutIfNeeded()
                
            }).disposed(by: disposeBag)
    }
    
    func bindOuput() {
        
        vm.output.tapButton.asDriver(onErrorJustReturn: User())
            .drive(onNext: { value in
                
            }).disposed(by: disposeBag)
        
        vm.output.buttonAble.asDriver(onErrorJustReturn: SurfMateError.SystemError.message)
            .drive(onNext: {[unowned self] value in
                
                if let value = value {
                    nicknameTF.layer.borderWidth = 1
                    nicknameTF.layer.borderColor = UIColor.errorColor.cgColor
                    nicknameTF.titleLB.textColor = UIColor.errorColor
                    nicknameAlertLB.text = value
                    nicknameAlertLB.alpha = 1
                    nextBT.isEnabled = false
                } else {
                    nicknameTF.layer.borderWidth = 0
                    nicknameTF.layer.borderColor = nil
                    nicknameTF.titleLB.textColor =  UIColor.rgb(red: 123, green: 127, blue: 131)
                    nicknameAlertLB.alpha = 0
                    nextBT.isEnabled = true
                }
                
            }).disposed(by: disposeBag)
        
    }
    
}
