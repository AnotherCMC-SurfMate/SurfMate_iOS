//
//  BirthSignUpViewController.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/03/14.
//

import UIKit
import RxCocoa
import RxSwift
import RxKeyboard

class BirthSignUpViewController: UIViewController {

    let vm: BirthSignUpViewModel
    
    private let disposeBag = DisposeBag()
    
    let backBT = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "back_bt"), for: .normal)
    }
    
    let pageLB = UILabel().then {
        $0.text = "2/7"
        $0.textColor = UIColor(red: 0.741, green: 0.749, blue: 0.757, alpha: 1)
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 15)
    }
    
    lazy var titleLB = UILabel().then {
        let text = "\(vm.user.username)님의 \n생년월일도 알려주세요!"
        let attributedText = NSMutableAttributedString.pretendard(text, .Display2, UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1))
        $0.attributedText = attributedText
        $0.numberOfLines = 2
    }
    
    let textFieldView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        $0.layer.cornerRadius = 12
    }
    
    let tfLB = UILabel().then {
        $0.text = "생년월일"
        $0.textColor = UIColor.rgb(red: 123, green: 127, blue: 131)
        $0.textAlignment = .left
        $0.font = UIFont.pretendard(size: 13, family: .bold)
    }
    
    lazy var yearTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "1990", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 0.741, green: 0.749, blue: 0.757, alpha: 1)])
        $0.textColor = .black
        $0.font = UIFont.pretendard(size: 15, family: .medium)
        $0.textAlignment = .left
        $0.delegate = self
        $0.tintColor = UIColor.mainColor
        $0.keyboardType = .numberPad
    }
    
    let spOneLB = UILabel().then {
        $0.text = "/"
        $0.textColor = UIColor(red: 0.483, green: 0.498, blue: 0.512, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Bold", size: 19)
    }
    
    lazy var monthTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "12", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 0.741, green: 0.749, blue: 0.757, alpha: 1)])
        $0.textColor = .black
        $0.font = UIFont.pretendard(size: 15, family: .medium)
        $0.textAlignment = .left
        $0.tintColor = UIColor.mainColor
        $0.delegate = self
        $0.keyboardType = .numberPad
    }
    
    let spTwoLB = UILabel().then {
        $0.text = "/"
        $0.textColor = UIColor(red: 0.483, green: 0.498, blue: 0.512, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Bold", size: 19)
    }
    
    lazy var dayTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "06", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 0.741, green: 0.749, blue: 0.757, alpha: 1)])
        $0.textColor = .black
        $0.font = UIFont.pretendard(size: 15, family: .medium)
        $0.textAlignment = .left
        $0.keyboardType = .numberPad
        $0.tintColor = UIColor.mainColor
        $0.delegate = self
    }
    
    
    let nextBT = SignUpButton(text: "다음")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
    }
    
    init(_ vm: BirthSignUpViewModel) {
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

extension BirthSignUpViewController {
    
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
        
        safeArea.addSubview(textFieldView)
        textFieldView.snp.makeConstraints {
            $0.top.equalTo(titleLB.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(74)
        }
        
        textFieldView.addSubview(tfLB)
        tfLB.snp.makeConstraints {
            $0.top.equalToSuperview().offset(9)
            $0.leading.equalToSuperview().offset(18)
            $0.height.equalTo(20)
        }
        
        textFieldView.addSubview(yearTextField)
        yearTextField.snp.makeConstraints {
            $0.top.equalTo(tfLB.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(18)
            $0.height.equalTo(28)
            $0.width.equalTo(46)
        }
        
        textFieldView.addSubview(spOneLB)
        spOneLB.snp.makeConstraints {
            $0.top.equalTo(tfLB.snp.bottom).offset(6)
            $0.leading.equalTo(yearTextField.snp.trailing).offset(28)
            $0.width.equalTo(8)
            $0.height.equalTo(28)
        }
        
        textFieldView.addSubview(monthTextField)
        monthTextField.snp.makeConstraints {
            $0.top.equalTo(tfLB.snp.bottom).offset(6)
            $0.leading.equalTo(spOneLB.snp.trailing).offset(28)
            $0.width.equalTo(25)
            $0.height.equalTo(28)
        }
        
        textFieldView.addSubview(spTwoLB)
        spTwoLB.snp.makeConstraints {
            $0.top.equalTo(tfLB.snp.bottom).offset(6)
            $0.leading.equalTo(monthTextField.snp.trailing).offset(31)
            $0.width.equalTo(8)
            $0.height.equalTo(28)
        }
        
        textFieldView.addSubview(dayTextField)
        dayTextField.snp.makeConstraints {
            $0.top.equalTo(tfLB.snp.bottom).offset(6)
            $0.leading.equalTo(spTwoLB.snp.trailing).offset(30)
            $0.width.equalTo(25)
            $0.height.equalTo(28)
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
        
        yearTextField.rx.controlEvent([.editingChanged])
            .map { self.yearTextField.text ?? ""}
            .bind(to: vm.input.yearRelay)
            .disposed(by: disposeBag)
        
        monthTextField.rx.controlEvent([.editingChanged])
            .map { self.monthTextField.text ?? ""}
            .bind(to: vm.input.monthRelay)
            .disposed(by: disposeBag)
        
        dayTextField.rx.controlEvent([.editingChanged])
            .map { self.dayTextField.text ?? ""}
            .bind(to: vm.input.dayRelay)
            .disposed(by: disposeBag)
        
        nextBT.rx.tap
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
        
        vm.output.userValue.asDriver(onErrorJustReturn: User())
            .drive(onNext: { user in
                
                let vm = GenderSignUpViewModel(user)
                let vc = GenderSignUpViewController(vm)
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(vc, animated: true)
                
            }).disposed(by: disposeBag)
        
        vm.output.buttonAble.asDriver(onErrorJustReturn: false)
            .drive(onNext: { value in
                self.nextBT.isEnabled = value
            }).disposed(by: disposeBag)
        
    }
    
}

extension BirthSignUpViewController: UITextFieldDelegate {
    
    //TextField에 포커싱이 감지될 때 label 컬러 변경
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        tfLB.textColor = UIColor.mainColor
        return true
    }
    
    //TextField에 포커싱이 빠져나갈 때 text에 따라 text컬러 변경
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text == "" {
            tfLB.textColor = UIColor.rgb(red: 123, green: 127, blue: 131)
        } else {
            tfLB.textColor = UIColor.mainColor
        }
        
        return true
    }
    
    //TextField에 따라 최대 글자수 변경
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return false }
            
        let maxLength = textField == yearTextField ? 4 : 2
        
        let newLength = text.count + string.count - range.length
        
        return newLength <= maxLength
        
        }
    
}
