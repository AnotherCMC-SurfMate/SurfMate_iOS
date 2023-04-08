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
    
    //API통신 시 실행되는 로딩창
    var ApiLoadingView:UIAlertController {
            get {
                let alert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
                
                let indicator = UIActivityIndicatorView(frame: .zero).then {
                    $0.style = .large
                    $0.hidesWhenStopped = true
                    $0.startAnimating()
                    $0.tintColor =  UIColor(red: 0.274, green: 0.173, blue: 0.9, alpha: 1)
                }
                
                alert.view.addSubview(indicator)
                indicator.snp.makeConstraints {
                    $0.centerY.centerX.equalToSuperview()
                    $0.width.height.equalTo(50)
                }
                
                
                
                return alert
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
    
    
    static let errorColor = UIColor.rgb(red: 237, green: 2, blue: 45)
    static let mainColor = UIColor.rgb(red: 253, green: 107, blue: 6)
}

