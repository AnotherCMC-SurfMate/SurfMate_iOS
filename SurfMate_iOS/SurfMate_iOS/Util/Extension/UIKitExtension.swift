//
//  UIKitExtension.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/02/14.
//

import UIKit

extension UIFont {
    
    enum Family:String {
        case bold = "Bold"
        case medium = "Medium"
        case regular = "Regular"
        case semiBold = "SemiBold"
    }
    
    static func pretendard(size: CGFloat = 10, family: Family = .regular) -> UIFont {
        return UIFont(name: "Pretendard-\(family.rawValue)", size: size)!
    }
    
}

extension UIViewController {
    
    //safeArea 영역의 view를 생성
    var safeArea:UIView {
        get {
            guard let safeArea = self.view.viewWithTag(Int(INT_MAX)) else {
                let guide = self.view.safeAreaLayoutGuide
                let view = UIView()
                view.tag = Int(INT_MAX)
                self.view.addSubview(view)
                view.snp.makeConstraints {
                    $0.edges.equalTo(guide)
                }
                return view
            }
            return safeArea
        }
    }
    
}
