//
//  AgreeNTermViewController.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/03/08.
//

import UIKit
import RxSwift
import RxCocoa


class AgreeNTermViewController: UIViewController {
    
    private let vm = AgreeNTermViewModel()
    private let disposeBag = DisposeBag()
    
    weak var delegate:MainLoginViewDelegate?
    
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let contentView = UIView()
    
    let titleLB = UILabel().then {
        $0.text = "약관에 동의해주세요"
        $0.textColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Bold", size: 22)
    }
    
    let subTitleLB = UILabel().then {
        $0.text = "<>를 이용하기 위한 약관에 동의해주세요"
        $0.textColor = UIColor(red: 0.565, green: 0.576, blue: 0.592, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 15)
    }
    
    let allAgreeBT = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "checkmark"), for: .normal)
    }
    
    let allAgreeLB = UILabel().then {
        $0.text = "전체 동의"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 18)
    }
    
    let allSubAgreeLB = UILabel().then {
        $0.text = "서비스 이용을 위해 아래 약관에 모두 동의합니다"
        $0.textColor = UIColor(red: 0.565, green: 0.576, blue: 0.592, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 13)
    }
    
    let separator = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
    }
    
    let firstAgreeBT = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "checkmark"), for: .normal)
    }
    
    let firstAgreeLB = UILabel().then {
        $0.text = "(필수) 14세 이상입니다."
        $0.textColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 13)
    }
    
    let firstAgreeDetailBT = UIButton(type: .custom).then {
        let text = "보기"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor.rgb(red: 222, green: 222, blue: 222), range: NSRange(location: 0, length: text.count))
        attributedText.addAttribute(.font, value: UIFont.pretendard(size: 13, family: .medium), range: NSRange(location: 0, length: text.count))
        $0.setAttributedTitle(attributedText, for: .normal)
    }
    
    let secondAgreeBT = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "checkmark"), for: .normal)
    }
    
    let secondAgreeLB = UILabel().then {
        $0.text = "(필수) 서비스 이용약관 동의"
        $0.textColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 13)
    }
    
    let secondAgreeDetailBT = UIButton(type: .custom).then {
        let text = "보기"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor.rgb(red: 222, green: 222, blue: 222), range: NSRange(location: 0, length: text.count))
        attributedText.addAttribute(.font, value: UIFont.pretendard(size: 13, family: .medium), range: NSRange(location: 0, length: text.count))
        $0.setAttributedTitle(attributedText, for: .normal)
    }
    
    let thirdAgreeBT = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "checkmark"), for: .normal)
    }
    
    let thirdAgreeLB = UILabel().then {
        $0.text = "(필수) 서비스 이용약관 동의"
        $0.textColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 13)
    }
    
    let thirdAgreeDetailBT = UIButton(type: .custom).then {
        let text = "보기"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor.rgb(red: 222, green: 222, blue: 222), range: NSRange(location: 0, length: text.count))
        attributedText.addAttribute(.font, value: UIFont.pretendard(size: 13, family: .medium), range: NSRange(location: 0, length: text.count))
        $0.setAttributedTitle(attributedText, for: .normal)
    }
    
    let forthAgreeBT = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "checkmark"), for: .normal)
    }
    
    let forthAgreeLB = UILabel().then {
        $0.text = "(필수) 서비스 이용약관 동의"
        $0.textColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 13)
    }
    
    let forthAgreeDetailBT = UIButton(type: .custom).then {
        let text = "보기"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor.rgb(red: 222, green: 222, blue: 222), range: NSRange(location: 0, length: text.count))
        attributedText.addAttribute(.font, value: UIFont.pretendard(size: 13, family: .medium), range: NSRange(location: 0, length: text.count))
        $0.setAttributedTitle(attributedText, for: .normal)
    }
    
    let fithAgreeBT = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "checkmark"), for: .normal)
    }
    
    let fithAgreeLB = UILabel().then {
        $0.text = "(필수) 서비스 이용약관 동의"
        $0.textColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Medium", size: 13)
    }
    
    let fithAgreeDetailBT = UIButton(type: .custom).then {
        let text = "보기"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor.rgb(red: 222, green: 222, blue: 222), range: NSRange(location: 0, length: text.count))
        attributedText.addAttribute(.font, value: UIFont.pretendard(size: 13, family: .medium), range: NSRange(location: 0, length: text.count))
        $0.setAttributedTitle(attributedText, for: .normal)
    }
    
    let nextBT = SignUpButton(text: "동의완료")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
    }
    
    
    
    
}

extension AgreeNTermViewController {
    
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().offset(0.78)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.width.centerX.top.bottom.equalToSuperview()
        }
        
        contentView.addSubview(titleLB)
        titleLB.snp.makeConstraints {
            $0.top.equalToSuperview().offset(51)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(32)
        }
        
        contentView.addSubview(subTitleLB)
        subTitleLB.snp.makeConstraints {
            $0.top.equalTo(titleLB.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(23)
        }
        
        contentView.addSubview(allAgreeBT)
        allAgreeBT.snp.makeConstraints {
            $0.top.equalTo(subTitleLB.snp.bottom).offset(39)
            $0.leading.equalToSuperview().offset(24)
            $0.width.height.equalTo(23)
        }
        
        contentView.addSubview(allAgreeLB)
        allAgreeLB.snp.makeConstraints {
            $0.top.equalTo(subTitleLB.snp.bottom).offset(37)
            $0.leading.equalTo(allAgreeBT.snp.trailing).offset(12)
            $0.height.equalTo(28)
        }
        
        contentView.addSubview(allSubAgreeLB)
        allSubAgreeLB.snp.makeConstraints {
            $0.top.equalTo(allAgreeLB.snp.bottom).offset(2)
            $0.leading.equalTo(allAgreeLB.snp.leading)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(separator)
        separator.snp.makeConstraints {
            $0.top.equalTo(allSubAgreeLB.snp.bottom).offset(16.5)
            $0.leading.equalToSuperview().offset(24.5)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(1)
        }
        
        contentView.addSubview(firstAgreeBT)
        firstAgreeBT.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(16.5)
            $0.leading.equalToSuperview().offset(24)
            $0.width.height.equalTo(23)
        }
        
        contentView.addSubview(firstAgreeLB)
        firstAgreeLB.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(18.5)
            $0.leading.equalTo(firstAgreeBT.snp.trailing).offset(12)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(firstAgreeDetailBT)
        firstAgreeDetailBT.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(18.5)
            $0.leading.lessThanOrEqualTo(firstAgreeLB.snp.trailing).offset(147)
            $0.trailing.equalToSuperview().offset(-22)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(secondAgreeBT)
        secondAgreeBT.snp.makeConstraints {
            $0.top.equalTo(firstAgreeBT.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
            $0.width.height.equalTo(23)
        }
        
        contentView.addSubview(secondAgreeLB)
        secondAgreeLB.snp.makeConstraints {
            $0.top.equalTo(firstAgreeLB.snp.bottom).offset(17)
            $0.leading.equalTo(secondAgreeBT.snp.trailing).offset(12)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(secondAgreeDetailBT)
        secondAgreeDetailBT.snp.makeConstraints {
            $0.top.equalTo(firstAgreeDetailBT.snp.bottom).offset(16)
            $0.leading.lessThanOrEqualTo(secondAgreeLB.snp.trailing).offset(147)
            $0.trailing.equalToSuperview().offset(-22)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(thirdAgreeBT)
        thirdAgreeBT.snp.makeConstraints {
            $0.top.equalTo(secondAgreeBT.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(24)
            $0.width.height.equalTo(23)
        }
        
        contentView.addSubview(thirdAgreeLB)
        thirdAgreeLB.snp.makeConstraints {
            $0.top.equalTo(secondAgreeLB.snp.bottom).offset(17)
            $0.leading.equalTo(thirdAgreeBT.snp.trailing).offset(12)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(thirdAgreeDetailBT)
        thirdAgreeDetailBT.snp.makeConstraints {
            $0.top.equalTo(secondAgreeDetailBT.snp.bottom).offset(16)
            $0.leading.lessThanOrEqualTo(thirdAgreeLB.snp.trailing).offset(147)
            $0.trailing.equalToSuperview().offset(-22)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(forthAgreeBT)
        forthAgreeBT.snp.makeConstraints {
            $0.top.equalTo(thirdAgreeBT.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(24)
            $0.width.height.equalTo(23)
        }
        
        contentView.addSubview(forthAgreeLB)
        forthAgreeLB.snp.makeConstraints {
            $0.top.equalTo(thirdAgreeLB.snp.bottom).offset(17)
            $0.leading.equalTo(forthAgreeBT.snp.trailing).offset(12)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(forthAgreeDetailBT)
        forthAgreeDetailBT.snp.makeConstraints {
            $0.top.equalTo(thirdAgreeDetailBT.snp.bottom).offset(16)
            $0.leading.lessThanOrEqualTo(forthAgreeLB.snp.trailing).offset(147)
            $0.trailing.equalToSuperview().offset(-22)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(fithAgreeBT)
        fithAgreeBT.snp.makeConstraints {
            $0.top.equalTo(forthAgreeBT.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(24)
            $0.width.height.equalTo(23)
        }
        
        contentView.addSubview(fithAgreeLB)
        fithAgreeLB.snp.makeConstraints {
            $0.top.equalTo(forthAgreeLB.snp.bottom).offset(17)
            $0.leading.equalTo(fithAgreeBT.snp.trailing).offset(12)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(fithAgreeDetailBT)
        fithAgreeDetailBT.snp.makeConstraints {
            $0.top.equalTo(forthAgreeDetailBT.snp.bottom).offset(16)
            $0.leading.lessThanOrEqualTo(fithAgreeLB.snp.trailing).offset(147)
            $0.trailing.equalToSuperview().offset(-22)
            $0.height.equalTo(20)
            
        }
        
        contentView.addSubview(nextBT)
        nextBT.snp.makeConstraints {
            $0.top.equalTo(fithAgreeLB).offset(108)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    private func bind() {
        bindInput()
        bindOutput()
    }
    
    private func bindInput() {
        
        allAgreeBT.rx.tap
            .bind(to: vm.input.allAgreeRelay)
            .disposed(by: disposeBag)
        
        firstAgreeBT.rx.tap
            .bind(to: vm.input.firstAgreeRelay)
            .disposed(by: disposeBag)
        
        secondAgreeBT.rx.tap
            .bind(to: vm.input.secondAgreeRelay)
            .disposed(by: disposeBag)
        
        thirdAgreeBT.rx.tap
            .bind(to: vm.input.thirdAgreeRelay)
            .disposed(by: disposeBag)
        
        forthAgreeBT.rx.tap
            .bind(to: vm.input.forthAgreeRelay)
            .disposed(by: disposeBag)
        
        fithAgreeBT.rx.tap
            .bind(to: vm.input.fithAgreeRelay)
            .disposed(by: disposeBag)
        
        nextBT.rx.tap
            .subscribe(onNext: {
                
                self.dismiss(animated: true) {
                    self.delegate?.dismissAgreeNTermsViewController()
                }
                
            }).disposed(by: disposeBag)
        
    }
    
    private func bindOutput() {
        
        vm.output.agreeDriver.asDriver(onErrorJustReturn: [false, false, false, false, false])
            .drive(onNext: { [unowned self] value in
                
                if value[0] {
                    firstAgreeBT.setImage(UIImage(named: "checkmark_fill"), for: .normal)
                } else {
                    firstAgreeBT.setImage(UIImage(named: "checkmark"), for: .normal)
                }
                
                if value[1] {
                    secondAgreeBT.setImage(UIImage(named: "checkmark_fill"), for: .normal)
                } else {
                    secondAgreeBT.setImage(UIImage(named: "checkmark"), for: .normal)
                }
                
                if value[2] {
                    thirdAgreeBT.setImage(UIImage(named: "checkmark_fill"), for: .normal)
                } else {
                    thirdAgreeBT.setImage(UIImage(named: "checkmark"), for: .normal)
                }
                
                if value[3] {
                    forthAgreeBT.setImage(UIImage(named: "checkmark_fill"), for: .normal)
                } else {
                    forthAgreeBT.setImage(UIImage(named: "checkmark"), for: .normal)
                }
                
                if value[4] {
                    fithAgreeBT.setImage(UIImage(named: "checkmark_fill"), for: .normal)
                } else {
                    fithAgreeBT.setImage(UIImage(named: "checkmark"), for: .normal)
                }
                
                if value == [true, true, true, true, true] {
                    allAgreeBT.setImage(UIImage(named: "checkmark_fill"), for: .normal)
                    nextBT.isEnabled = true
                    
                } else if value == [true, true, true, true, false] {
                    nextBT.isEnabled = true
                    allAgreeBT.setImage(UIImage(named: "checkmark"), for: .normal)
                } else {
                    nextBT.isEnabled = false
                    allAgreeBT.setImage(UIImage(named: "checkmark"), for: .normal)
                }
                
                
                
            }).disposed(by: disposeBag)
        
    }
    
    
    
}
