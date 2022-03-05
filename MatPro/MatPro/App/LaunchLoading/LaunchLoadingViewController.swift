//
//  LaunchLoadingViewController.swift
//  MatPro
//
//  Created by Austin Betzer on 10/9/21.
//

import Foundation
import UIKit

class LaunchLoadingViewController: UIViewController {
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppFlowManager.presentMainTab()
    }
}
