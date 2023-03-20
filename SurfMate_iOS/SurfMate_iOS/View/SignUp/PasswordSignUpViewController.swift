//
//  PasswordSignUpViewController.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/03/17.
//

import UIKit
import RxCocoa
import RxSwift

class PasswordSignUpViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
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
    
    let pwTF = DefaultTextField(text: "인증번호", placeHolder: "영문, 숫자 포함 8자리 이상")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    
}
