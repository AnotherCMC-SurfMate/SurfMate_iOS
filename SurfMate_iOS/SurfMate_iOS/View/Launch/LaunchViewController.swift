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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        //        PhoneAuthProvider.provider().verifyPhoneNumber("+82 01082836380", uiDelegate: nil) { verificationID, error in
        //
        //            if let id = verificationID {
        //
        //                print(id)
        //
        //            }
        //
        //            if let error = error {
        //
        //                print(error)
        //
        //            }
        //
        //
        //        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let vc = DefaultLoginViewController()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    
    
}

