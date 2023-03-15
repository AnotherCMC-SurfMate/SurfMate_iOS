//
//  PhNumSignUpViewController.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/03/15.
//

import UIKit
import RxCocoa
import RxSwift

class PhNumSignUpViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    let vm:PhNumSignUpViewModel
    
    let backBT = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "back_bt"), for: .normal)
    }
    
    let pageLB = UILabel().then {
        $0.text = "4/7"
        $0.textColor = UIColor(red: 0.741, green: 0.749, blue: 0.757, alpha: 1)
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 15)
    }
    
    let titleLB = UILabel().then {
        $0.text = "본인 확인을 위해\n전화번호를 입력해주세요!"
        $0.numberOfLines = 2
        $0.textColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Bold", size: 26)
    }
    
    let phNumTF = DefaultTextField(text: "전화번호", placeHolder: "휴대폰 번호 11자리").then {
        $0.textField.keyboardType = .numberPad
    }
    
    let nextBT = SignUpButton(text: "다음")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
    }
    
    init(_ vm: PhNumSignUpViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

extension PhNumSignUpViewController {
    
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
        
        safeArea.addSubview(phNumTF)
        phNumTF.snp.makeConstraints {
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
    
    func bind() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {
        
        phNumTF.textField.rx.controlEvent([.editingDidEnd])
            .map { self.phNumTF.textField.text ?? "" }
            .bind(to: vm.input.phNumRelay)
            .disposed(by: disposeBag)
        
    }
    
    func bindOutput() {
        
    }
    
    
}
