//
//  RecordingViewController.swift
//  MatPro
//
//  Created by Austin Betzer on 10/9/21.
//

import Foundation
import UIKit
import AVFoundation

class RecordingViewController: BaseViewController {
    // MARK: - Outlets
    
    // MARK: - Properties
    private var session: AVCaptureSession?
    private let output = AVCapturePhotoOutput()
    private let previewLayer = AVCaptureVideoPreviewLayer()
    
    private let shutterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.layer.cornerRadius = 100
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    
    
    // MARK: - View Life Cycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        previewLayer.frame = view.bounds
        shutterButton.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height - 200)
        
        if let previewLayerConnection = previewLayer.connection,
            previewLayerConnection.isVideoOrientationSupported {
            updatePreviewLayer(layer: previewLayerConnection, orientation: UIApplication.shared.statusBarOrientation.videoOrientation)
          }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterButton)
        UIUtils.lockOrientation(.landscapeRight, andRotateTo: .landscapeRight)
        shutterButton.addTarget(self, action: #selector(capturePhoto), for: .touchUpInside)
        checkForCameraPermissions()
    }
    
    @objc func capturePhoto() {
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    private func updatePreviewLayer(layer: AVCaptureConnection, orientation: AVCaptureVideoOrientation) {
      layer.videoOrientation = orientation
      previewLayer.frame = self.view.bounds
    }
    
    private func checkForCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard let strongSelf = self, granted else {
                    return
                }
                
                DispatchQueue.main.async {
                    strongSelf.setupCamera()
                }
            }
        case .restricted:
            // show alert
            navigateUsersToSettings()
        case .denied:
            // show alert
            navigateUsersToSettings()
        case .authorized:
            setupCamera()
        @unknown default:
            break
        }
    }
    
    private func navigateUsersToSettings() {
        presentSimpleAlert(title: "Camera Permissions Restricted",
                           message: "Go to settings and enable camera permissions to record content.",
                           okayTitle: "Go to Settings") {
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
    }
    
    private func setupCamera() {
        let session = AVCaptureSession()
        
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                
                session.startRunning()
                self.session  = session
            } catch (let error) {
                print("[RecordingViewController]: Failed to setup camera with error: \(error)")
            }
        }
    }

}

extension RecordingViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
    }
}

// MARK: - Orientation
extension RecordingViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
}


