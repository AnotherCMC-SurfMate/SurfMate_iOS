//
//  AlertSheet.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/03/16.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

protocol AlertSheetDelegate: AnyObject {
    
    func dismissAction(_ action: AlertAction)
    
}

class AlertSheetController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var delegate:AlertSheetDelegate?
    let header:String
    let contents:String
    let alertAction:AlertAction
    
    lazy var titleLB = UILabel().then {
        $0.textColor = UIColor(red: 0.388, green: 0.4, blue: 0.416, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Bold", size: 30)
        $0.text = header
    }
    
    lazy var contensLB = UILabel().then {
        $0.text = contents
        $0.textColor = UIColor(red: 0.388, green: 0.4, blue: 0.416, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Bold", size: 19)
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    let confirmBT = SignUpButton(text: "확인").then {
        $0.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
    }
    
    init(header: String, contents: String, alertAction: AlertAction) {
        self.header = header
        self.contents = contents
        self.alertAction = alertAction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

extension AlertSheetController {
    
    func setUI() {
        view.backgroundColor = .white
        
        if header == "" {
            view.addSubview(contensLB)
            contensLB.snp.makeConstraints {
                $0.top.equalToSuperview().offset(46)
                $0.centerX.equalToSuperview()
                $0.height.equalTo(56)
            }
        } else {
            view.addSubview(titleLB)
            titleLB.snp.makeConstraints {
                $0.top.equalToSuperview().offset(34)
                $0.centerX.equalToSuperview()
                $0.height.equalTo(34)
            }
            
            view.addSubview(contensLB)
            contensLB.snp.makeConstraints {
                $0.top.equalTo(titleLB.snp.bottom).offset(12)
                $0.leading.trailing.equalToSuperview()
                $0.height.greaterThanOrEqualTo(56)
            }
        }
        
        
        
        view.addSubview(confirmBT)
        confirmBT.snp.makeConstraints {
            $0.top.equalTo(contensLB.snp.bottom).offset(35)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(56)
        }
        
        
    }
    
    func bind() {
        confirmBT.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true) {
                    self.delegate?.dismissAction(self.alertAction)
                }
            }).disposed(by: disposeBag)
    }
    
    
}
