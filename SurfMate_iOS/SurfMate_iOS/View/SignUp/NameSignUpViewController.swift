//
//  NameSignUpViewController.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/03/09.
//

import UIKit
import RxSwift
import RxCocoa

class NameSignUpViewController: UIViewController {

    let vm:NameSignUpViewModel
    
    private let disposeBag = DisposeBag()
    
    let backBT = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "back_bt"), for: .normal)
    }
    
    let pageLB = UILabel().then {
        $0.text = "1/7"
        $0.textColor = UIColor(red: 0.741, green: 0.749, blue: 0.757, alpha: 1)
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 15)
    }
    
    let titleLB = UILabel().then {
        $0.text = "서픽에 온 걸 환영해요🏄\n이름을 알려주세요!"
        $0.textColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Bold", size: 26)
    }
    
    let nameTF = DefaultTextField(text: "이름", placeHolder: "홍길동")
    
    let nextBT = SignUpButton(text: "다음")
    
    init(_ vm: NameSignUpViewModel) {
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

extension NameSignUpViewController {
    
    private func setUI() {
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
        
        safeArea.addSubview(nameTF)
        nameTF.snp.makeConstraints {
            $0.top.equalTo(titleLB.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(74)
        }
        
        safeArea.addSubview(nextBT)
        nextBT.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-41)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(56)
        }
        
    }
    
    private func bind() {
        bindInput()
        bindOutput()
    }
    
    private func bindInput() {
        nameTF.textField.rx.controlEvent([.editingChanged])
            .map { self.nameTF.textField.text ?? ""}
            .bind(to: vm.input.textRelay)
            .disposed(by: disposeBag)
    }
    
    private func bindOutput() {
        
        vm.output.buttonAbleRelay.asDriver(onErrorJustReturn: false)
            .drive(onNext: {[unowned self] value in
                if value {
                    nextBT.isEnabled = true
                } else {
                    nextBT.isEnabled = false
                }
            }).disposed(by: disposeBag)
        
    }
    
}
