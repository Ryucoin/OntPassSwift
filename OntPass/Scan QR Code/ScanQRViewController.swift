//
//  ScanQRViewController.swift
//  OntPass
//
//  Created by Ross Krasner on 12/8/18.
//  Copyright © 2018 Ryu. All rights reserved.
//

import UIKit
import AVFoundation

class ScanQRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = self.view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        layoutCameraOverlay()
        
        captureSession.startRunning()
        
        
    }
    
    private func layoutCameraOverlay() {
        let cameraOverlayView = UIView(frame: view.frame)
        cameraOverlayView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        let windowView = UIView(frame: CGRect(x: screenWidth * 0.125,
                                              y: 100, width: screenWidth * 0.75,
                                              height: screenWidth * 0.75))
        cameraOverlayView.addSubview(windowView)
        windowView.layer.borderColor = UIColor.white.cgColor
        windowView.layer.cornerRadius = 20.0
        windowView.layer.borderWidth = 3.0
        
        let path: CGMutablePath = CGMutablePath()
        path.addRect(cameraOverlayView.bounds)
        path.addRoundedRect(in: windowView.frame.insetBy(dx: 3.0, dy: 3.0),
                            cornerWidth: 20.0 - 3.0,
                            cornerHeight: 20.0 - 3.0)
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillRule = CAShapeLayerFillRule.evenOdd
        
        cameraOverlayView.layer.mask = shape
        
        let previewView = UIView(frame: view.frame)
        
        self.view.addSubview(previewView)
        
        previewView.layer.addSublayer(previewLayer)
        
        let cancelButton = UIButton()
        let attributedX = NSMutableAttributedString(string: "×", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 75.0,
                                                           weight: UIFont.Weight.ultraLight),
            NSAttributedString.Key.foregroundColor: UIColor.white ])
        cancelButton.setAttributedTitle(attributedX, for: .normal)
        cancelButton.frame = CGRect(x: 0, y: 0, width: 60, height: 75)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: UIControl.Event.touchUpInside)
        
        cameraOverlayView.addSubview(cancelButton)
        
        self.view.addSubview(cameraOverlayView)
    }
    
    @objc func cancelTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func failed() {
        let alert = UIAlertController(title: "Scanning not supported",
                                      message:
            "Your device does not support scanning a code from an item. Please use a device with a camera.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
        if captureSession?.isRunning == false {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        
        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
    }
    
    func found(code: String) {
        print(code)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }


}
