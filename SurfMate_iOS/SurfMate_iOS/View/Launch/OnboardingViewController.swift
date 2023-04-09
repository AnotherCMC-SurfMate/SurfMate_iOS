//
//  OnboardingViewController.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/04/09.
//

import UIKit
import Then
import RxSwift
import RxCocoa

class OnboardingViewController: UIViewController {
    
   private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    private let titleLB = UILabel().then {
        let attributedText = NSMutableAttributedString.pretendard("섶메로 친구 구하고\n함께 서핑하러가요!", .Header1, .black)
        $0.attributedText = attributedText
        $0.numberOfLines = 2
    }
    
    
    private lazy var guideScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.alwaysBounceVertical = false
        $0.isScrollEnabled = true
        $0.bounces = false
        $0.backgroundColor = .gray
        $0.delegate = self
        $0.contentSize = CGSize(width: (UIScreen.main.bounds.width - 183) * 4, height: 270)
    }
    
    private let pageControl = UIPageControl().then {
        $0.currentPage = 0
        $0.numberOfPages = 4
        $0.direction = .leftToRight
        $0.pageIndicatorTintColor = .darkGray
        $0.currentPageIndicatorTintColor = .brown
    }
    
    private let nextBT = UIButton(type: .custom).then {
        let attributedText = NSMutableAttributedString.pretendard("시작하기", .Title1, .black)
        $0.setAttributedTitle(attributedText, for: .normal)
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 11
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    
}

extension OnboardingViewController {
    
    func setUI() {
        view.backgroundColor = .white
        safeArea.addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.width.centerX.top.bottom.equalToSuperview()
        }
        
        contentView.addSubview(titleLB)
        titleLB.snp.makeConstraints {
            $0.top.equalToSuperview().offset(86)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(64)
        }
        
        contentView.addSubview(guideScrollView)
        guideScrollView.snp.makeConstraints {
            $0.top.equalTo(titleLB.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(91)
            $0.trailing.equalToSuperview().offset(-92)
            $0.height.equalTo(270)
        }
        
        contentView.addSubview(pageControl)
        pageControl.snp.makeConstraints {
            $0.top.equalTo(guideScrollView.snp.bottom).offset(53)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(11)
        }
        
        contentView.addSubview(nextBT)
        nextBT.snp.makeConstraints {
            $0.top.equalTo(pageControl.snp.bottom).offset(132)
            $0.leading.equalToSuperview().offset(111)
            $0.trailing.equalToSuperview().offset(-111)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().offset(-43)
        }
        
    }
    
}

extension OnboardingViewController: UIScrollViewDelegate {
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / scrollView.frame.width)
        self.pageControl.currentPage = page
      }
}
