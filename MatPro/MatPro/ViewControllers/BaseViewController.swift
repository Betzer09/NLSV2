//
//  BaseViewController.swift
//  MatPro
//
//  Created by Austin Betzer on 1/15/22.
//

import Foundation
import UIKit


class BaseViewController: UIViewController {
    
    
        
   
}


// MARK: - Alerts
extension UIViewController {
    /**
     Presents a simple alert
     
     - parameter vc: The view controller you want to present on
     - parameter title: Optional: The title of the alert, if you pass in nil the title will be set to 'Error'
     - parameter message: The message that should display in the alert
     - parameter onDismiss: An optional code block that runs after the user has presses the okay action
     */
    func presentSimpleAlert(title: String?, message: String?, okayTitle: String? = "OK", onDismiss: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: okayTitle, style: .default) { (_) in
            onDismiss?()
        }
        
        alert.addAction(okayAction)
        self.present(alert, animated: true)
    }
}
