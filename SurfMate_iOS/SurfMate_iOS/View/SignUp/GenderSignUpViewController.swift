//
//  GenderSignUpViewController.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/03/15.
//

import UIKit
import RxCocoa
import RxSwift
import RxKeyboard

class GenderSignUpViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    let vm:GenderSignUpViewModel
    
    let backBT = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "back_bt"), for: .normal)
    }
    
    let pageLB = UILabel().then {
        $0.text = "3/7"
        $0.textColor = UIColor(red: 0.741, green: 0.749, blue: 0.757, alpha: 1)
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 15)
    }
    
    lazy var titleLB = UILabel().then {
        let text = "\(vm.user.username)님의 성별은\n어떻게 되시나요?"
        let attributedText = NSMutableAttributedString.pretendard(text, .Display2, UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1))
        $0.attributedText = attributedText
        $0.numberOfLines = 2
    }
    
    let maleBT = UIButton(type: .custom).then {
        $0.backgroundColor = UIColor.rgb(red: 245, green: 245, blue: 245)
    }
    
    let femaleBT = UIButton(type: .custom).then {
        $0.backgroundColor = UIColor.rgb(red: 245, green: 245, blue: 245)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
    }
    
    init(_ vm: GenderSignUpViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension GenderSignUpViewController {
    
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
        
        safeArea.addSubview(maleBT)
        maleBT.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.lessThanOrEqualToSuperview().offset(24)
            $0.width.height.equalTo(154)
        }
        
        safeArea.addSubview(femaleBT)
        femaleBT.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(maleBT.snp.trailing).offset(20)
            $0.trailing.greaterThanOrEqualToSuperview().offset(-24)
            $0.width.height.equalTo(154)
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
        
        maleBT.rx.tap
            .bind(to: vm.input.maleRelay)
            .disposed(by: disposeBag)
        
        femaleBT.rx.tap
            .bind(to: vm.input.femaleRelay)
            .disposed(by: disposeBag)
        
    }
    
    func bindOutput() {
        
        vm.output.genderValue.asDriver(onErrorJustReturn: User())
            .drive(onNext: { user in
                
                let vm = PhNumSignUpViewModel(user)
                let vc = PhNumSignUpViewController(vm, .SignUp)
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(vc, animated: true)
                
            }).disposed(by: disposeBag)
        
    }
    
}
