//
//  CompleteSignUpViewController.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/03/24.
//

import UIKit
import RxSwift
import RxCocoa

class CompleteSignUpViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    let titleLB = UILabel().then {
        $0.text = "\(User.loginedUser?.nickname ?? "줄리")님\n타보자GO! 에\n오신 걸 환영합니다 🥳"
        $0.numberOfLines = 3
        $0.textColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Bold", size: 26)
    }
    
    let nextBT = SignUpButton(text: "확인").then {
        $0.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
    }
    
}

extension CompleteSignUpViewController {
    
    func setUI() {
        
        view.backgroundColor = .white
        safeArea.addSubview(titleLB)
        titleLB.snp.makeConstraints {
            $0.top.equalToSuperview().offset(31)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(102)
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
    }
    
    func bindInput() {
        nextBT.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
    }
    
    
}


