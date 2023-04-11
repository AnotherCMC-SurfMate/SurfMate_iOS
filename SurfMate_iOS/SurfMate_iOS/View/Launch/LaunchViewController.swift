//
//  ViewController.swift
//  SurfMate_iOS
//
//  Created by Jun on 2022/11/30.
//

import UIKit
import FirebaseAuth
import SnapKit

class LaunchViewController: UIViewController {
    
    let logoImageView = UIImageView().then {
        $0.backgroundColor = .gray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let vc = AccessRightsViewController()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    
    
}

extension LaunchViewController{
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(192)
        }
        
        
    }
    
    
    
}

