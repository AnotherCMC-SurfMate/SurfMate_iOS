//
//  UIKitExtension.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/02/14.
//

import UIKit
import TextFieldEffects

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
    
    func showErrorAlert(msg: String) {
        let alert = UIAlertController(title: "에러", message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    
    static let mainColor = UIColor.rgb(red: 253, green: 107, blue: 6)
}

