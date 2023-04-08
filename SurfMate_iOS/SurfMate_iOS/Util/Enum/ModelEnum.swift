//
//  CustomEnum.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/02/01.
//

import Foundation

/*
 로그인 타입 정의
    - 카카오 로그인
    - 구글 로그인
    - 네이버 로그인
    - 애플 로그인
    - 일반 로그인
 */
enum LoginType: String, Codable {
    case kakao = "KAKAO"
    case google = "GOOGLE"
    case naver = "NAVER"
    case apple = "APPLE"
    case normal = "NORMAL"
}

/*
 Sheet에 성질에 따른 함수 설정
 */
enum AlertAction {
    case normal
    case goToLogin
    case next
}

/*
 비밀번호 변경 View와 회원가입 View를 재사용하기 위한 ENUM
 */
enum PWPageMode {
    case SignUp
    case Change
}
