//
//  UIUtils.swift
//  AnneCraigFitness
//
//  Created by Austin Betzer on 7/23/21.
//

import Foundation
import UIKit


/**
 This class is used to create reusable UI components that are shared across multiple screens. For example
 custom alerts, xib presentations, etc
 */
class UIUtils {
    /**
     Presents a simple alert
     
     - parameter vc: The view controller you want to present on
     - parameter title: Optional: The title of the alert, if you pass in nil the title will be set to 'Error'
     - parameter message: The message that should display in the alert
     - parameter onDismiss: An optional code block that runs after the user has presses the okay action
     */
    static func presentSimpleAlert(vc: UIViewController, title: String?, message: String?, okayTitle: String? = "OK", onDismiss: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: okayTitle, style: .default) { (_) in
            onDismiss?()
        }
        
        alert.addAction(okayAction)
        vc.present(alert, animated: true)
    }
    
    /// Presents the main section of the app
    static func presentMainTab() {
        DispatchQueue.main.async {
            let scene = UIApplication.shared.connectedScenes.first
            
            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                sd.window?.rootViewController = Storyboards.main.initialize()
            }
            
        }
    }
    
    /**
     Assists with locking orientation
     
     - parameter orientation: Desired orientation our app supports
     */
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.supportedOrientation = orientation
        }
    }
    
    /// Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
}

// MARK: - App Navigation

/**
 Storyboards that are in the consumer app
 */
public enum Storyboards: String {
    /// The root tab bar
    case main
    case recording
    
    /**
     Creates a storyboard instance
     - parameter storyboardName: The name of the storyboard name
     */
    func initialize(storyboardName: String? = nil) -> UIViewController {
        if let name = storyboardName {
            return UIStoryboard(name: "\(self)".capitalizingFirstLetter(), bundle: nil).instantiateViewController(withIdentifier: name)
        } else {
            return UIStoryboard(name: "\(self)".capitalizingFirstLetter(), bundle: nil).instantiateInitialViewController()!
        }
    }
}
