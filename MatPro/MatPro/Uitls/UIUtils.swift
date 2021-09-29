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
    
    /// Presents the main login screen
    static func presentAuth() {
        DispatchQueue.main.async {
            let scene = UIApplication.shared.connectedScenes.first
            
            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                sd.window?.rootViewController = Storyboards.auth.initialize(storyboardName: "login")
            }
        }
    }
    
    static func presentVideo() {
        DispatchQueue.main.async {
            let scene = UIApplication.shared.connectedScenes.first
            
            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                sd.window?.rootViewController = Storyboards.video.initialize()
            }
        }
    }
}

// MARK: - App Navigation

/**
 Storyboards that are in the consumer app
 */
public enum Storyboards: String {
    /// The root tab bar
    case main
    case auth
    case workoutList
    case workoutDetails
    case exerciseDetails
    case video
    
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
