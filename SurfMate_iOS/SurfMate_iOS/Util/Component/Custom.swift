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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String) {
        self.init()
        self.text = text
        self.isEnabled = false
        
    }
    
}


class DefaultTextField: UIView {
    
    private let disposeBag = DisposeBag()
    
    let titleLB = UILabel().then {
        $0.textColor = UIColor.rgb(red: 123, green: 127, blue: 131)
        $0.textAlignment = .left
        $0.font = UIFont.pretendard(size: 13, family: .bold)
    }
    
    lazy var accessoryView: UIView = {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 56))
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        return view
    }()
    
    lazy var textField = UITextField().then {
        $0.inputAccessoryView = accessoryView
        
        $0.textColor = .black
        $0.font = UIFont.pretendard(size: 15, family: .medium)
        $0.textAlignment = .left
        $0.delegate = self
    }
    
    let button = DefaultButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String, placeHolder: String) {
        self.init()
        titleLB.text = text
        textField.placeholder = placeHolder
    }
    
    func setUI() {
        backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        layer.cornerRadius = 12
        
        
        
        addSubview(titleLB)
        
        titleLB.snp.makeConstraints {
            $0.top.equalToSuperview().offset(9)
            $0.leading.equalToSuperview().offset(18)
            $0.height.equalTo(20)
        }
        
        addSubview(textField)
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLB.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(18)
            $0.trailing.equalToSuperview().offset(-18)
            $0.bottom.equalToSuperview().offset(-11)
        }
        
    }
    
    
    
}

extension DefaultTextField: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        titleLB.textColor = UIColor.mainColor
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text == "" {
            titleLB.textColor = UIColor.rgb(red: 123, green: 127, blue: 131)
        } else {
            titleLB.textColor = UIColor.mainColor
        }
        
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
