//
//  MainTabViewController.swift
//  MatPro
//
//  Created by Austin Betzer on 10/9/21.
//

import Foundation
import UIKit

class MainTabViewController: UIViewController {
    
    
    @IBAction private func startTapped (_ sender: Any) {
        let vc = Storyboards.recording.initialize()
        navigationController?.pushViewController(vc, animated: true)
    }
}