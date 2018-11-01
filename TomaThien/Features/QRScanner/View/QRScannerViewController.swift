//
//  QRScannerController.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/28/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit
import Foundation

class QRScannerViewController: UIViewController, QRScannerViewProtocol {
    var presenter: QRScannerPresenterProtocol?
    
    //MARK: - Properties config camera
    private lazy var metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
    private lazy var captureSession = AVCaptureSession()
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var results: [String: String] = [String: String]()
    
    //MARK: - Properties Square
    private lazy var squareView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "qrCode_square")
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        return imageView
    }()
    private let squarePadding: CGFloat = 20
    private let squareBorder: CGFloat = 2
    private lazy var topView: UIView = {
        return self.createViewElement()
    }()
    private lazy var leftView: UIView = {
        return self.createViewElement()
    }()
    private lazy var rightView: UIView = {
        return self.createViewElement()
    }()
    private lazy var bottomView: UIView = {
        return self.createViewElement()
    }()
    fileprivate lazy var colorDefault: UIColor = {
        return UIColor(white: 0 , alpha: 0.5)
    }()
    
    fileprivate var parentVCL: UIViewController?
    
    fileprivate var squareFrame: CGRect {
        let squareWidth = UIScreen.main.bounds.size.width - self.squarePadding * 2
        let barHeight = UIApplication.shared.statusBarFrame.height + (self.parentVCL?.navigationController?.navigationBar.frame.size.height ?? 0)
        let originX: CGFloat = (UIScreen.main.bounds.width - squareWidth) / 2
        let originY: CGFloat = (UIScreen.main.bounds.height - squareWidth) / 2 - barHeight
        return CGRect(x: originX, y: originY, width: squareWidth, height: squareWidth)
    }
    
    //MARK: - Processing Status
    enum ProcessGoType {
        case up
        case down
    }
    fileprivate var timer: Timer?
    
    fileprivate lazy var processingView: UIView = {
        let view = UIView()
        let width = self.squareFrame.width - self.squareBorder * 2
        view.frame = CGRect(x: self.squareFrame.origin.x + self.squareBorder , y: self.squareFrame.origin.y, width: width, height: 1)
        view.backgroundColor = UIColor.red
        return view
    }()
 
    //MARK: - SetupView
    private lazy var captureMetadataOutput = AVCaptureMetadataOutput()
    
    private func setupView() {
        self.squareView.frame = self.squareFrame
        self.configBackground()
        self.view.layer.addSublayer(self.squareView.layer)
    }
    
    private func configBackground() {
        let frame = self.squareView.frame
        self.topView.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: frame.origin.y + squareBorder))
        self.bottomView.frame = CGRect(x: 0, y: frame.origin.y + frame.size.height - squareBorder, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - squareBorder)
        self.leftView.frame = CGRect(x: 0, y: frame.origin.y + squareBorder, width: frame.origin.x + squareBorder, height: frame.size.height - 2 * squareBorder)
        self.rightView.frame = { () -> CGRect in
            var f = self.leftView.frame
            f.origin.x = frame.origin.x + frame.size.width - squareBorder
            f.size.width = UIScreen.main.bounds.width - f.origin.x
            return f
        }()
    }
    
    
    fileprivate func createViewElement() -> UIView {
        let nView = UIView()
        nView.isUserInteractionEnabled = false
        nView.backgroundColor = self.colorDefault
        self.view.layer.addSublayer(nView.layer)
        return nView
    }
    
    //MARK: - Config Camera
    private func configCamera() {
        let captureDevice = AVCaptureDevice.default(for: .video)
        // Check if captureDevice returns a value and unwrap it
        if let captureDevice = captureDevice {
            guard let input = try? AVCaptureDeviceInput(device: captureDevice) else {
                return
            }
            captureSession.addInput(input)
            
            captureSession.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = metadataObjectTypes
            if !isSupport() {
                return
            }
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = .resizeAspectFill
            videoPreviewLayer?.frame = view.frame
            guard let videoLayer = videoPreviewLayer else {
                return
            }
            view.layer.insertSublayer(videoLayer, at: 0)
        }
    }
    
    fileprivate func isSupport() -> Bool {
        return metadataObjectTypes.first(where: { metaData in
            return !captureMetadataOutput.availableMetadataObjectTypes.contains(metaData)
        }) == nil
    }
    
    func startScanning() {
        if !captureSession.isRunning {
            captureSession.startRunning()
        }
    }
    
    func stopScanning() {
        if captureSession.isRunning && captureSession.inputs.count > 0 {
            captureSession.stopRunning()
        }
    }
    
    //MARK: - Override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        AppUtility.lockOrientation(.portrait)
        self.configCamera()
        self.startScanning()
        self.setupView()
        self.startLoadingView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
    }
    
    deinit {
        self.clearTimer()
        guard self.results.count > 0 else { return }
    }
    //MARK: - Function
    private func clearTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func startLoadingView() {
        self.view.layer.addSublayer(self.processingView.layer)
        clearTimer()
        timer = Timer.scheduledTimer(timeInterval: 0.01,
                                     target: self,
                                     selector: #selector(showProccessingState),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc private func showProccessingState() {
        let topOrigin = self.squareFrame.origin.y
        let bottomOrigin = self.squareFrame.origin.y + self.squareFrame.height
        let currentY = self.processingView.frame.origin.y
        self.moveProcessStatus = currentY >= bottomOrigin ? .up : (currentY <= topOrigin ? .down : self.moveProcessStatus )
    }
    
    fileprivate let processingDuration: TimeInterval = 0.3
    
    private var moveProcessStatus: ProcessGoType = .down {
        didSet {
            if moveProcessStatus == .down {
                UIView.animate(withDuration: processingDuration) {
                    self.processingView.frame.origin.y += 2
                }
            } else {
                UIView.animate(withDuration: processingDuration) {
                    self.processingView.frame.origin.y -= 2
                }
            }
        }
    }
}


extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            debugPrint("No QR code is detected")
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObjectTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata (or barcode) then update the status label's text and set the bounds
            if let data = metadataObj.stringValue {
                self.stopScanning()
                let popup = QRScannerResultPopupView(json: data)
                popup.delegate = self
                popup.modalPresentationStyle = .overFullScreen
                self.present(popup, animated: true, completion: nil)
            }
        }
    }
}

extension QRScannerViewController: QRScannerResultPopupViewDelegate {
    func didDismiss() {
        self.startScanning()
    }
    
    func didConfirm(result: (id: String, name: String)) {
        self.results[result.id] = result.name
    }
}

