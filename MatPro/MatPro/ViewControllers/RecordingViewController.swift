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
    
    // MARK: - Properties
    private var captureSession: AVCaptureSession?
    private let videoOutput = AVCaptureMovieFileOutput()
    private let previewLayer = AVCaptureVideoPreviewLayer()
    
    private var isRecordingInProgress: Bool = false
    
    private let shutterButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "icon-record"), for: .normal)
        return button
    }()
    
    
    // MARK: - View Life Cycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        previewLayer.frame = view.bounds
        
        if let previewLayerConnection = previewLayer.connection,
            previewLayerConnection.isVideoOrientationSupported {
            updatePreviewLayer(layer: previewLayerConnection, orientation: UIApplication.shared.statusBarOrientation.videoOrientation)
          }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.addSublayer(previewLayer)
        UIUtils.lockOrientation(.landscapeRight, andRotateTo: .landscapeRight)
        configureShutterButton()
        shutterButton.addTarget(self, action: #selector(toggleVideoCapture), for: .touchUpInside)
        checkForCameraPermissions()
    }
    
    private func configureShutterButton() {
        view.addSubview(shutterButton)
        shutterButton.translatesAutoresizingMaskIntoConstraints = false
        shutterButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        shutterButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        shutterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shutterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
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

// MARK: - AVCaptureFileOutputRecordingDelegate
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
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Your video was successfully saved", message: nil, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    @objc func toggleVideoCapture() {
        configureVideoCapture()
    }
    
    private func configureVideoCapture() {
        if isRecordingInProgress {
            stopVideoCapture()
        } else {
            startVideoCapture()
        }
        
        isRecordingInProgress.toggle()
    }
    
    private func startVideoCapture() {
        print("[RecordingViewController]: Starting to record")
        shutterButton.layer.borderColor = UIColor.red.cgColor
        guard let captureSession = captureSession, captureSession.isRunning else {
            print("[RecordingViewController]: No capture session was found and recording could not be started.")
            return
        }
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileUrl = paths[0].appendingPathComponent("output.mp4")
        
        // Remove previous video if it exists
        try? FileManager.default.removeItem(at: fileUrl)
        videoOutput.startRecording(to: fileUrl, recordingDelegate: self)
        
    }
    
    private func stopVideoCapture() {
        print("[RecordingViewController]: stopping recording")
        shutterButton.layer.borderColor = UIColor.white.cgColor
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


