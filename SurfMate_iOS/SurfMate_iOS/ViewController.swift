//
//  ViewController.swift
//  SurfMate_iOS
//
//  Created by Jun on 2022/11/30.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        HealthRepository.shared.healthCheck { result in
            
            print(result)
        }
        
        // Do any additional setup after loading the view.
    }


}

