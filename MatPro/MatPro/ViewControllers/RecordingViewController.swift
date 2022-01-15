//
//  RecordingViewController.swift
//  MatPro
//
//  Created by Austin Betzer on 10/9/21.
//

import Foundation
import UIKit
import AVFoundation
import Photos

class RecordingViewController: BaseViewController {
    // MARK: - Outlets
    
    // MARK: - Properties
    private var captureSession: AVCaptureSession?
    private let videoOutput = AVCaptureMovieFileOutput()
    private let previewLayer = AVCaptureVideoPreviewLayer()
    
    private let shutterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    
    
    // MARK: - View Life Cycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        previewLayer.frame = view.bounds
        shutterButton.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height - 80)
        
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
        shutterButton.addTarget(self, action: #selector(toggleVideoCapture), for: .touchUpInside)
        checkForCameraPermissions()
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
                
                if session.canAddOutput(videoOutput) {
                    session.addOutput(videoOutput)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                
                session.startRunning()
                self.captureSession  = session
            } catch (let error) {
                print("[RecordingViewController]: Failed to setup camera with error: \(error)")
            }
        }
    }

}

extension RecordingViewController: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
        if let error = error {
            print("[RecordingViewController]: failed to get output URL from av capture output delegate: \(error)")
            return
        }
        
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: outputFileURL)
        }) { saved, error in
            if saved {
                let alertController = UIAlertController(title: "Your video was successfully saved", message: nil, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    @objc func toggleVideoCapture() {
        guard let captureSession = captureSession else {
            print("[RecordingViewController]: No capture session was found.")
            return
        }
        
        if captureSession.isRunning {
            stopRecording()
        } else {
            startVideoCapture()
        }
    }
    
    func startVideoCapture() {
        guard let captureSession = captureSession, captureSession.isRunning else {
            print("[RecordingViewController]: No capture session was found and recording could not be started.")
            return
        }
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileUrl = paths[0].appendingPathComponent("output.mp4")
        
        do {
            try FileManager.default.removeItem(at: fileUrl)
            videoOutput.startRecording(to: fileUrl, recordingDelegate: self)
        } catch (let error) {
            print("[RecordingViewController]: failed to remove item from file manager: \(error)")
        }
        
    }
    
    func stopRecording() {
        guard let captureSession = self.captureSession, captureSession.isRunning else {
            print("[RecordingViewController]: No capture session was found and recording could not be stopped.")
            return
        }
        videoOutput.stopRecording()
    }
}

// MARK: - Orientation
extension RecordingViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

enum RecordingViewControllerError: Error {
    case captureSessionIsMissing
}


