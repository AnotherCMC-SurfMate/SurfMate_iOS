//
//  AccessRightsViewController.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/04/10.
//

import UIKit
import RxCocoa
import RxSwift
import AVFoundation
import Photos
import CoreLocation

class AccessRightsViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private lazy var locationManager = CLLocationManager().then {
        $0.delegate = self
    }
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    let titleLB = UILabel().then {
        let attributedText = NSMutableAttributedString.pretendard("앱 사용을 위해\n접근 권한을 허용해주세요", .Display2, .black)
        $0.attributedText = attributedText
        $0.numberOfLines = 2
    }
    
    let subTitleLB = UILabel().then {
        let attributedText = NSMutableAttributedString.pretendard("선택적 접근 권한", .본문2, .black)
        attributedText.addAttribute(.foregroundColor, value: UIColor.mainColor, range: NSRange(location: 0, length: 3))
        $0.attributedText = attributedText
    }
    
    let contentsLB = UILabel().then {
        let attributedText = NSMutableAttributedString.pretendard("미동의 시에도 하루운동 서비스를 이용할 수 있으나.\n일부 서비스의 이용이 제한 될 수 있습니다.", .본문5, UIColor.rgb(red: 123, green: 127, blue: 131))
        $0.attributedText = attributedText
        $0.numberOfLines = 2
    }
    
    let pushNotiBT = UIButton(type: .custom).then {
        $0.isSelected = UIApplication.shared.isRegisteredForRemoteNotifications
        $0.setImage(UIImage(named: "checkbox_disable"), for: .normal)
        $0.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
    }
    
    let pushNotiLB = UILabel().then {
        $0.text = "알림"
        $0.font = UIFont.pretendard(size: 15, family: .bold)
        $0.textColor = UIColor(red: 0.483, green: 0.498, blue: 0.512, alpha: 1)
    }
    
    let pushNotiSubLB = UILabel().then {
        $0.text = "알림 메시지 발송"
        $0.textColor = UIColor(red: 0.483, green: 0.498, blue: 0.512, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Regular", size: 13)
    }
    
    let cameraBT = UIButton(type: .custom).then {
        $0.isSelected = AVCaptureDevice.authorizationStatus(for: .video) == .authorized ? true : false
        $0.setImage(UIImage(named: "checkbox_disable"), for: .normal)
        $0.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
    }
    
    let cameraLB = UILabel().then {
        $0.text = "카메라"
        $0.font = UIFont.pretendard(size: 15, family: .bold)
        $0.textColor = UIColor(red: 0.483, green: 0.498, blue: 0.512, alpha: 1)
    }
    
    let cameraSubLB = UILabel().then {
        $0.text = "자동차 촬영"
        $0.textColor = UIColor(red: 0.483, green: 0.498, blue: 0.512, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Regular", size: 13)
    }
    
    let pictureBT = UIButton(type: .custom).then {
        $0.isSelected = PHPhotoLibrary.authorizationStatus(for: .readWrite) == .authorized ? true : false
        $0.setImage(UIImage(named: "checkbox_disable"), for: .normal)
        $0.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
    }
    
    let pictureLB = UILabel().then {
        $0.text = "사진"
        $0.font = UIFont.pretendard(size: 15, family: .bold)
        $0.textColor = UIColor(red: 0.483, green: 0.498, blue: 0.512, alpha: 1)
    }
    
    let pictureSubLB = UILabel().then {
        $0.text = "프로필 및 자동차 사진"
        $0.textColor = UIColor(red: 0.483, green: 0.498, blue: 0.512, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Regular", size: 13)
    }
    
    lazy var locationBT = UIButton(type: .custom).then {
        $0.isSelected = locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse ? true : false
        $0.setImage(UIImage(named: "checkbox_disable"), for: .normal)
        $0.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
    }
    
    let locationLB = UILabel().then {
        $0.text = "위치"
        $0.font = UIFont.pretendard(size: 15, family: .bold)
        $0.textColor = UIColor(red: 0.483, green: 0.498, blue: 0.512, alpha: 1)
    }
    
    let locationSubLB = UILabel().then {
        $0.text = "사용자 위치 확인"
        $0.textColor = UIColor(red: 0.483, green: 0.498, blue: 0.512, alpha: 1)
        $0.font = UIFont(name: "Pretendard-Regular", size: 13)
    }
    
    let locationDetailBT = UIButton(type: .custom).then {
        let text = "위치기반 서비스 이용약관 자세히 보기"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor(red: 0.483, green: 0.498, blue: 0.512, alpha: 1), range: NSRange(location: 0, length: text.count))
        attributedText.addAttribute(.font, value: UIFont(name: "Pretendard-Regular", size: 13)!, range: NSRange(location: 0, length: text.count))
        attributedText.addAttribute(.underlineColor, value: UIColor(red: 0.483, green: 0.498, blue: 0.512, alpha: 1), range: NSRange(location: 0, length: text.count))
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        $0.setAttributedTitle(attributedText, for: .normal)
    }
    
    let divider = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
    }
    
    let moreInfoLB = UILabel().then {
        let attributedText = NSMutableAttributedString.pretendard("※ 설정 > 애플리케이션 > 섶메 > 권한 메뉴에서도\n설정하실 수 있습니다.", .본문5, UIColor.rgb(red: 144, green: 147, blue: 151))
        $0.attributedText = attributedText
        $0.numberOfLines = 2
    }
    
    let nextBT = UIButton(type: .custom).then {
        $0.layer.cornerRadius = 11
        $0.backgroundColor = UIColor.mainColor
        let text = "확인"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: text.count))
        attributedText.addAttribute(.font, value: UIFont.pretendard(size: 18, family: .bold), range: NSRange(location: 0, length: text.count))
        $0.setAttributedTitle(attributedText, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
    }
    
    
    
}

extension AccessRightsViewController {
    
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
            $0.top.equalToSuperview().offset(66)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(68)
        }
        
        contentView.addSubview(subTitleLB)
        subTitleLB.snp.makeConstraints {
            $0.top.equalTo(titleLB.snp.bottom).offset(18)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(23)
        }
        
        contentView.addSubview(contentsLB)
        contentsLB.snp.makeConstraints {
            $0.top.equalTo(subTitleLB.snp.bottom).offset(7)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(40)
        }
        
        contentView.addSubview(pushNotiBT)
        pushNotiBT.snp.makeConstraints {
            $0.top.equalTo(contentsLB.snp.bottom).offset(43)
            $0.leading.equalToSuperview().offset(24)
            $0.height.width.equalTo(32)
        }
        
        contentView.addSubview(pushNotiLB)
        pushNotiLB.snp.makeConstraints {
            $0.top.equalTo(contentsLB.snp.bottom).offset(48)
            $0.leading.equalTo(pushNotiBT.snp.trailing).offset(24)
            $0.height.equalTo(23)
        }
        
        contentView.addSubview(pushNotiSubLB)
        pushNotiSubLB.snp.makeConstraints {
            $0.top.equalTo(contentsLB.snp.bottom).offset(48)
            $0.leading.equalTo(pushNotiLB.snp.trailing).offset(36)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(cameraBT)
        cameraBT.snp.makeConstraints {
            $0.top.equalTo(pushNotiBT.snp.bottom).offset(22)
            $0.leading.equalToSuperview().offset(24)
            $0.height.width.equalTo(32)
        }
        
        contentView.addSubview(cameraLB)
        cameraLB.snp.makeConstraints {
            $0.top.equalTo(pushNotiLB.snp.bottom).offset(31)
            $0.leading.equalTo(cameraBT.snp.trailing).offset(24)
            $0.height.equalTo(23)
        }
        
        contentView.addSubview(cameraSubLB)
        cameraSubLB.snp.makeConstraints {
            $0.top.equalTo(pushNotiSubLB.snp.bottom).offset(34)
            $0.leading.equalTo(cameraLB.snp.trailing).offset(36)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(pictureBT)
        pictureBT.snp.makeConstraints {
            $0.top.equalTo(cameraBT.snp.bottom).offset(22)
            $0.leading.equalToSuperview().offset(24)
            $0.height.width.equalTo(32)
        }
        
        contentView.addSubview(pictureLB)
        pictureLB.snp.makeConstraints {
            $0.top.equalTo(cameraLB.snp.bottom).offset(31)
            $0.leading.equalTo(pictureBT.snp.trailing).offset(24)
            $0.height.equalTo(23)
        }
        
        contentView.addSubview(pictureSubLB)
        pictureSubLB.snp.makeConstraints {
            $0.top.equalTo(cameraSubLB.snp.bottom).offset(34)
            $0.leading.equalTo(pictureLB.snp.trailing).offset(36)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(locationBT)
        locationBT.snp.makeConstraints {
            $0.top.equalTo(pictureBT.snp.bottom).offset(22)
            $0.leading.equalToSuperview().offset(24)
            $0.height.width.equalTo(32)
        }
        
        contentView.addSubview(locationLB)
        locationLB.snp.makeConstraints {
            $0.top.equalTo(pictureLB.snp.bottom).offset(31)
            $0.leading.equalTo(locationBT.snp.trailing).offset(24)
            $0.height.equalTo(23)
        }
        
        contentView.addSubview(locationSubLB)
        locationSubLB.snp.makeConstraints {
            $0.top.equalTo(pictureSubLB.snp.bottom).offset(34)
            $0.leading.equalTo(locationLB.snp.trailing).offset(36)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(locationDetailBT)
        locationDetailBT.snp.makeConstraints {
            $0.top.equalTo(locationSubLB.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(23)
        }
        
        contentView.addSubview(divider)
        divider.snp.makeConstraints {
            $0.top.equalTo(locationDetailBT.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(24.5)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(1)
        }
        
        contentView.addSubview(moreInfoLB)
        moreInfoLB.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(18)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(40)
        }
        
        contentView.addSubview(nextBT)
        nextBT.snp.makeConstraints {
            $0.top.equalTo(moreInfoLB.snp.bottom).offset(123)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().offset(-41)
        }
    }
    
    func bind() {
        
        pushNotiBT.rx.tap
            .subscribe(onNext: { [unowned self] in
                
                if pushNotiBT.isSelected {
                    UIApplication.shared.unregisterForRemoteNotifications()
                } else {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                
                pushNotiBT.isSelected.toggle()
                
            }).disposed(by: disposeBag)
        
        
        cameraBT.rx.tap
            .subscribe(onNext: {
                AVCaptureDevice.requestAccess(for: .video) {[unowned self] granted in
                    cameraBT.isSelected = granted
                }
            }).disposed(by: disposeBag)
        
        pictureBT.rx.tap
            .subscribe(onNext: {
                PHPhotoLibrary.requestAuthorization(for: .readWrite) {[unowned self] status in
                    switch status {
                    case .authorized:
                        pictureBT.isSelected = true
                    default:
                        pictureBT.isSelected = false
                    }
                }
            }).disposed(by: disposeBag)
        
        locationBT.rx.tap
            .subscribe(onNext: {[unowned self] in
                locationManager.requestWhenInUseAuthorization()
            }).disposed(by: disposeBag)
        
    }
    
}

extension AccessRightsViewController: CLLocationManagerDelegate {
    
    //위치권한이 변경될때 마다 locationBT 토글
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            locationBT.isSelected = true
        default:
            locationBT.isSelected = false
        }
    }
    
}
