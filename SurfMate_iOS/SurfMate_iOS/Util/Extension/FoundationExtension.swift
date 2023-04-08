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


extension NSMutableAttributedString {
    
    enum Family {
        case Display1
        case Display2
        case Header1
        case Header2
        case Title1
        case Title2
        case Title3
        case 본문1
        case 본문2
        case 본문3
        case 본문4
        case 본문5
        case 본문6
        case 본문7
    }
    
    //NSMutableAttributedString 디자인 컴포넌트화(폰트, 크기, 컬러, 자간, 줄간격 설정)
    static func pretendard(_ text:String, _ family:Family, _ color: UIColor) -> NSMutableAttributedString {
        let range = NSRange(location: 0, length: text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: color, range: range)
        let style = NSMutableParagraphStyle()
        
        switch family {
        case .Display1:
            let font = UIFont.pretendard(size: 42, family: .bold)
            style.maximumLineHeight = 52
            style.minimumLineHeight = 52
            attributedText.addAttribute(.font, value: font, range: range)
            attributedText.addAttribute(.paragraphStyle, value: style, range: range)
            attributedText.addAttribute(.baselineOffset, value: (style.maximumLineHeight - font.lineHeight) / 4, range: range)
        case .Display2:
            let font = UIFont.pretendard(size: 26, family: .bold)
            style.maximumLineHeight = 34
            style.minimumLineHeight = 34
            attributedText.addAttribute(.font, value: font, range: range)
            attributedText.addAttribute(.paragraphStyle, value: style, range: range)
            attributedText.addAttribute(.baselineOffset, value: (style.maximumLineHeight - font.lineHeight) / 4, range: range)
        case .Header1:
            let font = UIFont.pretendard(size: 22, family: .bold)
            style.maximumLineHeight = 32
            style.minimumLineHeight = 32
            attributedText.addAttribute(.paragraphStyle, value: style, range: range)
            attributedText.addAttribute(.font, value: font, range: range)
            attributedText.addAttribute(.baselineOffset, value: (style.maximumLineHeight - font.lineHeight) / 4, range: range)
        case .Header2:
            let font = UIFont.pretendard(size: 20, family: .bold)
            style.maximumLineHeight = 30
            style.minimumLineHeight = 30
            attributedText.addAttribute(.font, value: font, range: range)
            attributedText.addAttribute(.paragraphStyle, value: style, range: range)
            attributedText.addAttribute(.baselineOffset, value: (style.maximumLineHeight - font.lineHeight) / 4, range: range)
        case .Title1:
            let font = UIFont.pretendard(size: 19, family: .bold)
            style.maximumLineHeight = 28
            style.minimumLineHeight = 28
            attributedText.addAttribute(.font, value: font, range: range)
            attributedText.addAttribute(.paragraphStyle, value: style, range: range)
            attributedText.addAttribute(.baselineOffset, value: (style.maximumLineHeight - font.lineHeight) / 4, range: range)
        case .Title2:
            let font = UIFont.pretendard(size: 18, family: .bold)
            style.maximumLineHeight = 28
            style.minimumLineHeight = 28
            attributedText.addAttribute(.font, value: font, range: range)
            attributedText.addAttribute(.paragraphStyle, value: style, range: range)
            attributedText.addAttribute(.baselineOffset, value: (style.maximumLineHeight - font.lineHeight) / 4, range: range)
        case .Title3:
            let font = UIFont.pretendard(size: 18, family: .semiBold)
            style.maximumLineHeight = 28
            style.minimumLineHeight = 28
            attributedText.addAttribute(.font, value: font, range: range)
            attributedText.addAttribute(.paragraphStyle, value: style, range: range)
            attributedText.addAttribute(.baselineOffset, value: (style.maximumLineHeight - font.lineHeight) / 4, range: range)
        case .본문1:
            let font = UIFont.pretendard(size: 17, family: .regular)
            style.maximumLineHeight = 25
            style.minimumLineHeight = 25
            attributedText.addAttribute(.font, value: font, range: range)
            attributedText.addAttribute(.paragraphStyle, value: style, range: range)
            attributedText.addAttribute(.baselineOffset, value: (style.maximumLineHeight - font.lineHeight) / 4, range: range)
        case .본문2:
            let font = UIFont.pretendard(size: 15, family: .bold)
            style.maximumLineHeight = 23
            style.minimumLineHeight = 23
            attributedText.addAttribute(.font, value: font, range: range)
            attributedText.addAttribute(NSAttributedString.Key.kern, value: 0.1, range: range)
            attributedText.addAttribute(.paragraphStyle, value: style, range: range)
            attributedText.addAttribute(.baselineOffset, value: (style.maximumLineHeight - font.lineHeight) / 4, range: range)
        case .본문3:
            let font = UIFont.pretendard(size: 15, family: .semiBold)
            style.maximumLineHeight = 23
            style.minimumLineHeight = 23
            attributedText.addAttribute(.font, value: font, range: range)
            attributedText.addAttribute(NSAttributedString.Key.kern, value: 0.1, range: range)
            attributedText.addAttribute(.paragraphStyle, value: style, range: range)
            attributedText.addAttribute(.baselineOffset, value: (style.maximumLineHeight - font.lineHeight) / 4, range: range)
        case .본문4:
            let font = UIFont.pretendard(size: 15, family: .medium)
            style.maximumLineHeight = 23
            style.minimumLineHeight = 23
            attributedText.addAttribute(.font, value: font, range: range)
            attributedText.addAttribute(NSAttributedString.Key.kern, value: 0.1, range: range)
            attributedText.addAttribute(.paragraphStyle, value: style, range: range)
            attributedText.addAttribute(.baselineOffset, value: (style.maximumLineHeight - font.lineHeight) / 4, range: range)
        case .본문5:
            let font = UIFont.pretendard(size: 13, family: .regular)
            style.maximumLineHeight = 20
            style.minimumLineHeight = 20
            attributedText.addAttribute(.font, value: font, range: range)
            attributedText.addAttribute(.paragraphStyle, value: style, range: range)
            attributedText.addAttribute(.baselineOffset, value: (style.maximumLineHeight - font.lineHeight) / 4, range: range)
        case .본문6:
            let font = UIFont.pretendard(size: 13, family: .medium)
            style.maximumLineHeight = 20
            style.minimumLineHeight = 20
            attributedText.addAttribute(.font, value: font, range: range)
            attributedText.addAttribute(.paragraphStyle, value: style, range: range)
            attributedText.addAttribute(.baselineOffset, value: (style.maximumLineHeight - font.lineHeight) / 4, range: range)
        case .본문7:
            let font = UIFont.pretendard(size: 13, family: .bold)
            style.maximumLineHeight = 20
            style.minimumLineHeight = 20
            attributedText.addAttribute(.font, value: font, range: range)
            attributedText.addAttribute(.paragraphStyle, value: style, range: range)
            attributedText.addAttribute(.baselineOffset, value: (style.maximumLineHeight - font.lineHeight) / 4, range: range)
        }
        
        return attributedText
    }
    
    
}
