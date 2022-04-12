//
//  MainTabViewController.swift
//  MatPro
//
//  Created by Austin Betzer on 10/9/21.
//

import Foundation
import UIKit

class MainTabViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIUtils.lockOrientation(.portrait, andRotateTo: .portrait)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.startTapped(self)
        })
    }
    
    
    @IBAction private func startTapped (_ sender: Any) {
        let vc = MatchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
