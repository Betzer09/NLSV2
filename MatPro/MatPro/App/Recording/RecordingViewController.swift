//
//  RecordingViewController.swift
//  MatPro
//
//  Created by Austin Betzer on 10/9/21.
//

import Foundation
import UIKit

class RecordingViewController: SwiftyCamViewController {
    // MARK: - Outlets
    
    
    // MARK: - Properties
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        lockRotation()
        
    }

    
    // MARK: - View Overrides
    
    // MARK: - Actions
    
    // MARK: - Public methods
    
    // MARK: - Private
    
    private func lockRotation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            UIUtils.lockOrientation(.landscape, andRotateTo: .landscapeRight)
            self.allowAutoRotate = false
        })
    }
    
    private func setupCamera() {
        cameraDelegate = self
        defaultCamera = .rear
        videoGravity = .resizeAspectFill
        shouldPrompToAppSettings = true
        shouldUseDeviceOrientation = true
        audioEnabled = false
        flashMode = .off
        doubleTapCameraSwitch = false
    }
}

extension RecordingViewController: SwiftyCamViewControllerDelegate {
    
    func swiftyCamSessionDidStartRunning(_ swiftyCam: SwiftyCamViewController) {
        
    }
    
}

// MARK: - Orientation
extension RecordingViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var shouldAutorotate: Bool {
        setOrientationToLandscape()
        return false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
        
    }
    
    private func setOrientationToLandscape() {
           UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
       }
}

