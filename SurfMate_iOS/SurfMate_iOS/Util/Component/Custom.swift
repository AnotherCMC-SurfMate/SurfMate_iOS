//
//  Custom.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/02/21.
//

import Foundation
import UIKit

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
