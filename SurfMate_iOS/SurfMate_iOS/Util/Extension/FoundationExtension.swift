//
//  FoundationExtension.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/01/19.
//

import Foundation
import RxSwift

extension String{
    //숫자+문자 포함해서 8~20글자 사이의 text 체크하는 정규표현식
    func validpassword() -> Bool {
        let passwordreg = ("(?=.*[A-Za-z])(?=.*[0-9]).{8,20}")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return passwordtesting.evaluate(with: self)
    }
}
