//
//  Custom.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/02/21.
//

import Foundation
import UIKit
import RxSwift

class DefaultButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String, clearColor: Bool = true) {
        self.init()
        self.titleLabel?.text = text
        self.titleLabel?.font = UIFont.pretendard(size: 18, family: .bold)
        self.layer.borderColor = UIColor(red: 0.741, green: 0.749, blue: 0.757, alpha: 1).cgColor
        self.layer.borderWidth = 1
        
        if clearColor {
            backgroundColor = .white
        } else {
            backgroundColor = UIColor.rgb(red: 97, green: 97, blue: 97)
        }
        
    }
    
}




class DefaultTextField: UIView {
    
    var toggle:Bool = false
    
    private let disposeBag = DisposeBag()
    
    let titleLB = UILabel().then {
        $0.textColor = UIColor(red: 0.741, green: 0.749, blue: 0.757, alpha: 1)
        $0.textAlignment = .left
        $0.font = UIFont.pretendard(size: 13, family: .bold)
    }
    
    let textFieldView = UIView().then {
        $0.isHidden = true
    }
    
    lazy var textField = UITextField().then {
        $0.textColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)
        $0.font = UIFont.pretendard(size: 15, family: .medium)
        $0.textAlignment = .left
        $0.delegate = self
    }
    
    let cancelBT = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "default_tf_cancel"), for: .normal)
        $0.isHidden = true
    }
    
    let separator = UIView().then {
        $0.backgroundColor = UIColor(red: 0.741, green: 0.749, blue: 0.757, alpha: 1)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String) {
        self.init()
        
    }
    
 
    func setUI() {
        backgroundColor = .clear
        addSubview(titleLB)
        
        titleLB.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        addSubview(textFieldView)
        textFieldView.snp.makeConstraints {
            $0.top.equalTo(titleLB.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
        }
        
        textFieldView.addSubview(cancelBT)
        cancelBT.snp.makeConstraints {
            $0.trailing.centerY.equalToSuperview()
            $0.width.height.equalTo(16)
        }
        
        textFieldView.addSubview(textField)
        textField.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.trailing.equalTo(cancelBT.snp.leading).offset(-3)
            $0.height.equalTo(23)
        }
        
        addSubview(separator)
        separator.snp.makeConstraints {
            $0.top.equalTo(textFieldView.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
    }
    
    func bind() {
        
        cancelBT.rx.tap
            .subscribe(onNext: {
                self.textField.text = ""
            }).disposed(by: disposeBag)
        
        
    }
    
    
}

extension DefaultTextField: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        separator.backgroundColor = UIColor(red: 0.973, green: 0.643, blue: 0.161, alpha: 1)
        cancelBT.isHidden = false
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        separator.backgroundColor = UIColor(red: 0.741, green: 0.749, blue: 0.757, alpha: 1)
        cancelBT.isHidden = true
        return true
    }
    
}

class SignUpButton: UIButton {
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                let attributedText = NSMutableAttributedString(string: text)
                attributedText.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: text.count))
                attributedText.addAttribute(.font, value: UIFont.pretendard(size: 18, family: .bold), range: NSRange(location: 0, length: text.count))
                self.setAttributedTitle(attributedText, for: .normal)
                self.backgroundColor = UIColor.rgb(red: 248, green: 164, blue: 41)
            } else {
                let attributedText = NSMutableAttributedString(string: text)
                attributedText.addAttribute(.foregroundColor, value: UIColor(red: 0.741, green: 0.749, blue: 0.757, alpha: 1), range: NSRange(location: 0, length: text.count))
                attributedText.addAttribute(.font, value: UIFont.pretendard(size: 18, family: .bold), range: NSRange(location: 0, length: text.count))
                self.setAttributedTitle(attributedText, for: .normal)
                self.backgroundColor = UIColor.rgb(red: 189, green: 191, blue: 193)
            }
        }
    }
    
    var text:String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String) {
        self.init()
        self.text = text
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor(red: 0.741, green: 0.749, blue: 0.757, alpha: 1), range: NSRange(location: 0, length: text.count))
        attributedText.addAttribute(.font, value: UIFont.pretendard(size: 18, family: .bold), range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedText, for: .normal)
    }
    
    func setUp() {
        isEnabled = false
        layer.cornerRadius = 11
    }
}
