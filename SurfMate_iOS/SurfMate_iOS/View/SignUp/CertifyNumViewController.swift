//
//  CertifyNumViewController.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/03/16.
//

import UIKit
import RxCocoa
import RxSwift
import RxKeyboard

class CertifyNumViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    let vm:CertifyNumViewModel
    let mode:PWPageMode
    private var timer = Timer()
    
    let backBT = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "back_bt"), for: .normal)
    }
    
    let pageLB = UILabel().then {
        $0.text = "5/7"
        $0.textColor = UIColor(red: 0.741, green: 0.749, blue: 0.757, alpha: 1)
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 15)
    }
    
    let titleLB = UILabel().then {
        let text = "방금 받으신 📩\n인증번호를 입력해주세요!"
        let attributedText = NSMutableAttributedString.pretendard(text, .Display2, UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1))
        $0.attributedText = attributedText
        $0.numberOfLines = 2
        
        
    }
    
    let certifyNumTF = DefaultTextField(text: "인증번호", placeHolder: "000000").then {
        $0.textField.keyboardType = .numberPad
    }
    
    let timeLB = UILabel().then {
        $0.text = "3:00"
        $0.textColor = UIColor(red: 0.929, green: 0.008, blue: 0.176, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Regular", size: 13)
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
    
    init(_ vm: CertifyNumViewModel, _ mode: PWPageMode) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        setTimer()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
        
        certifyNumTF.addSubview(timeLB)
        
        certifyNumTF.textField.snp.remakeConstraints {
            $0.top.equalTo(certifyNumTF.titleLB.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(18)
            $0.height.equalTo(28)
        }
        
        timeLB.snp.makeConstraints {
            $0.top.equalTo(certifyNumTF.titleLB.snp.bottom).offset(10)
            $0.leading.equalTo(certifyNumTF.textField.snp.trailing).offset(18)
            $0.trailing.equalToSuperview().offset(-18)
            $0.height.equalTo(20)
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
        
        vm.output.ableValue.asDriver(onErrorJustReturn: false)
            .drive(onNext: { value in
                self.nextBT.isEnabled = value
            }).disposed(by: disposeBag)
        
        vm.output.confirmValue.asDriver(onErrorJustReturn: nil)
            .drive(onNext: { value in
                
                if let value {
                    
                    let vm = PasswordSignUpViewModel(value)
                    let vc = PasswordSignUpViewController(vm, self.mode)
                    vc.modalTransitionStyle = .coverVertical
                    vc.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(vc, animated: true)
                    
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
    
    private func setTimer() {
        
        timer.invalidate()
        
        var seconds = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            
            seconds += 1
            
            let remainSeconds = 180 - seconds
            
            guard seconds <= 180 else {
                self.timer.invalidate()
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.timeLB.text = "\(remainSeconds/60):\(String(format: "%02d", remainSeconds%60))"
            }
            
        })
        
        
    }
    
}
