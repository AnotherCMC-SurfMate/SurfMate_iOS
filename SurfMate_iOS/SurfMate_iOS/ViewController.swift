//
//  ViewController.swift
//  SurfMate_iOS
//
//  Created by Jun on 2022/11/30.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PhoneAuthProvider.provider().verifyPhoneNumber("+82 01082836380", uiDelegate: nil) { verificationID, error in
            
            if let id = verificationID {
                print(id)
            }
            
            if let error = error {
                print(error)
            }
            
            
        }
        
        // Do any additional setup after loading the view.
    }


}

