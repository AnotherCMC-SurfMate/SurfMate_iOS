//
//  CertifyNumViewController.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/03/16.
//

import UIKit
import RxCocoa
import RxSwift

class CertifyNumViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    let vm:CertifyNumViewModel
    
    let backBT = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "back_bt"), for: .normal)
    }
    
    let pageLB = UILabel().then {
        $0.text = "5/7"
        $0.textColor = UIColor(red: 0.741, green: 0.749, blue: 0.757, alpha: 1)
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 15)
    }
    
    let titleLB = UILabel().then {
        $0.text = "본인 확인을 위해\n전화번호를 입력해주세요!"
        $0.numberOfLines = 2
        $0.textColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Bold", size: 26)
        
    }
    
    let certifyNumTF = DefaultTextField(text: "인증번호", placeHolder: "000000").then {
        $0.textField.keyboardType = .numberPad
    }
    
    let getCertifyBT = UIButton(type: .custom).then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.741, green: 0.749, blue: 0.757, alpha: 1).cgColor
        $0.layer.cornerRadius = 12
        
        let text = "인증번호 재요청"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value:  UIColor(red: 0.565, green: 0.576, blue: 0.592, alpha: 1), range: NSRange(location: 0, length: text.count))
        attributedText.addAttribute(.font, value: UIFont(name: "Pretendard-SemiBold", size: 15)!, range: NSRange(location: 0, length: text.count))
        $0.setAttributedTitle(attributedText, for: .normal)
    }
    
    let nextBT = SignUpButton(text: "다음")
    
    init(_ vm: CertifyNumViewModel) {
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
    
}

extension CertifyNumViewController {
    
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
        
        safeArea.addSubview(certifyNumTF)
        certifyNumTF.snp.makeConstraints {
            $0.top.equalTo(titleLB.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(74)
        }
        
        safeArea.addSubview(getCertifyBT)
        getCertifyBT.snp.makeConstraints {
            $0.top.equalTo(certifyNumTF.snp.bottom).offset(27)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(56)
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
        
        certifyNumTF.textField.rx.controlEvent([.editingChanged])
            .map { self.certifyNumTF.textField.text ?? "" }
            .bind(to: vm.input.tfRelay)
            .disposed(by: disposeBag)
        
        getCertifyBT.rx.tap
            .bind(to: vm.input.getCertifyRelay)
            .disposed(by: disposeBag)
        
        nextBT.rx.tap
            .map { self.certifyNumTF.textField.text ?? "" }
            .bind(to: vm.input.certifyNumRelay)
            .disposed(by: disposeBag)
        
        
    }
    
    func bindOutput() {
        
        vm.output.ableValue.asDriver(onErrorJustReturn: false)
            .drive(onNext: { value in
                self.nextBT.isEnabled = value
            }).disposed(by: disposeBag)
        
        vm.output.confirmValue.asDriver(onErrorJustReturn: false)
            .drive(onNext: { value in
                if value {
                    
                } else {
                    let vc = AlertSheetController(header: "🥲", contents: "인증번호가 틀렸습니다.\n확인후 다시 입력해주세요.", alertAction: .next)
                    vc.sheetPresentationController?.detents = [
                        .custom(resolver: { context in
                            290
                        })
                    ]
                    self.present(vc, animated: true)
                }
            }).disposed(by: disposeBag)
        
        vm.output.resetValue
            .skip(1)
            .subscribe(onNext: {
                let vc = AlertSheetController(header: "📩", contents: "인증번호가 발송되었습니다. 3분 안에\n인증번호를 입력해주세요.", alertAction: .next)
                vc.sheetPresentationController?.detents = [
                    .custom(resolver: { context in
                        290
                    })
                ]
                self.present(vc, animated: true)
            }).disposed(by: disposeBag)
        
    }
    
}
