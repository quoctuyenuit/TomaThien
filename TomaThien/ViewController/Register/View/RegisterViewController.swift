//
//  RegisterViewController.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/31/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit


class RegisterViewController: UIViewController, RegisterViewProtocol {
    var presenter: RegisterPresenterProtocol?
    
    private var avatarImage: UIImage?
    
    
    private let textFieldPlacing: CGFloat = 5
    private let logoWidth: CGFloat = 60
    private let padding: CGFloat = 20
    private let textFieldHeight: CGFloat = 50
    private lazy var mainBound: UIView = {
        let bound = UIView()
        bound.backgroundColor = .white
        bound.layer.cornerRadius = 5
        bound.layer.masksToBounds = false
        bound.layer.shadowColor = UIColor.black.cgColor
        bound.layer.shadowOpacity = 0.5
        bound.layer.shadowOffset = .zero
        bound.layer.shadowRadius = 1
        
        return bound
    }()
    private lazy var headerBound: UIView = {
        let bound = UIView()
        
        return bound
    }()
    
    //MARK: - Properties Header
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.backgroundColor = .clear
        return imageView
    }()
    private lazy var largeTitle: UILabel = {
        let label = UILabel()
        label.text = "TomaThien"
        label.font = UIFont.sfuiMedium(size: 40)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private lazy var smallTitle: UILabel = {
        let label = UILabel()
        label.text = "Mời bạn đăng nhập để tiếp tục"
        label.font = UIFont.sfuiMedium()
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    //MARK: - Properties body
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    
    private let avatarSize: CGFloat = 65
    
    private lazy var avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = avatarSize / 2
        imageView.backgroundColor = .white
        imageView.clearsContextBeforeDrawing = true
        imageView.layer.borderWidth = 2
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.whiteTwo.cgColor
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "default_avatar")
        imageView.addGestureRecognizer(self.imageTapGesture)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTappedGesture(_:)))
    
    private lazy var name: UIBaseTextField = {
        let textField = UIBaseTextField()
        textField.placeholder = "Họ tên"
        return textField
    }()
    
    private lazy var phoneNumber: UIBaseTextField = {
        let textField = UIBaseTextField()
        textField.placeholder = "Số điện thoại"
        textField.inputType = InputType.numberInput
        return textField
    }()
    
    private lazy var email: UIBaseTextField = {
        let textField = UIBaseTextField()
        textField.placeholder = "Email"
        textField.inputType = InputType.emailInput
        return textField
    }()
    
    private lazy var birthDay: UIBaseTextField = {
        let textField = UIBaseTextField()
        textField.placeholder = "Ngày sinh"
        textField.inputType = InputType.dateInput
        return textField
    }()
    
    private lazy var identify: UIBaseTextField = {
        let textField = UIBaseTextField()
        textField.placeholder = "CMND"
        textField.inputType = InputType.numberInput
        return textField
    }()
    
    private lazy var password: UIBaseTextField = {
        let textField = UIBaseTextField()
        textField.placeholder = "Mật khẩu đăng nhập"
        textField.inputType = InputType.textInput
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var school: UIBaseTextField = {
        let textField = UIBaseTextField()
        textField.placeholder = "Sinh viên trường"
        textField.inputType = InputType.textInput
        return textField
    }()
    
    private lazy var address: UIBaseTextField = {
        let textField = UIBaseTextField()
        textField.placeholder = "Địa chỉ"
        textField.inputType = InputType.textInput
        return textField
    }()
    
    private lazy var yearOfAdmission: UIBaseTextField = {
        let textField = UIBaseTextField()
        textField.placeholder = "Năm nhập học"
        textField.inputType = InputType.numberInput
        return textField
    }()
    
    private lazy var yearsOfStudy: UIBaseTextField = {
        let textField = UIBaseTextField()
        textField.placeholder = "Thời gian học (năm)"
        textField.inputType = InputType.decimalInput
        return textField
    }()
    
    private lazy var team: UIBaseTextField = {
        let textField = UIBaseTextField()
        textField.placeholder = "Thuộc nhóm"
        textField.inputType = InputType.teamInput
        return textField
    }()
    
    private lazy var bodyBound: UIView = {
        let bound = UIView()
        return bound
    }()
    
    private lazy var registerButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Đăng ký", for: .normal)
        btn.layer.cornerRadius = 3
        btn.titleLabel?.textColor = .white
        btn.titleLabel?.font = UIFont.sfuiMedium()
        btn.backgroundColor = UIColor.appBase
        btn.addTarget(self, action: #selector(registerTapped(_:)), for: .touchUpInside)
        btn.layer.shadowColor = UIColor.lightGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: -3)
        btn.layer.shadowRadius = 1
        btn.layer.shadowOpacity = 0.3
        btn.layer.masksToBounds = false
        return btn
    }()
    
    private func getTextField(placeHolder: String) -> TextField{
        let textField = TextField()
        textField.textField.placeholder = placeHolder
        textField.textField.textColor = .black
        textField.textField.tintColor = .appBase
        textField.textField.isSecureTextEntry = true
        return textField
    }
    
    //MARK: - SetupView functions
    private func setupTitle() {
        self.logoImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(self.logoWidth)
            make.centerX.equalToSuperview()
        }
        self.largeTitle.snp.makeConstraints { (make) in
            make.top.equalTo(self.logoImageView.snp.bottom).offset(40)
            make.left.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(0)
        }
        self.smallTitle.snp.makeConstraints { (make) in
            make.top.equalTo(self.largeTitle.snp.bottom).offset(30)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().priority(.medium)
        }
    }
    
    private func setupBody() {
        self.headerBound.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.greaterThanOrEqualTo(0)
        }
        
        self.avatar.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerBound.snp.bottom).offset(30)
            make.left.equalToSuperview()
            make.width.height.equalTo(avatarSize)
        }
        self.name.snp.makeConstraints { (make) in
            make.left.equalTo(self.avatar.snp.right).offset(10)
            make.right.equalToSuperview()
            make.centerY.equalTo(self.avatar.snp.centerY)
            make.height.equalTo(self.textFieldHeight)
        }
        self.phoneNumber.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.avatar.snp.bottom).offset(self.textFieldPlacing)
            make.height.equalTo(self.textFieldHeight)
        }
        self.email.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.phoneNumber.snp.bottom).offset(self.textFieldPlacing)
            make.height.equalTo(self.textFieldHeight)
        }
        self.birthDay.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.email.snp.bottom).offset(self.textFieldPlacing)
            make.height.equalTo(self.textFieldHeight)
        }
        self.identify.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.birthDay.snp.bottom).offset(self.textFieldPlacing)
            make.height.equalTo(self.textFieldHeight)
        }
        self.password.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.identify.snp.bottom).offset(self.textFieldPlacing)
            make.height.equalTo(self.textFieldHeight)
        }
        self.school.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.password.snp.bottom).offset(self.textFieldPlacing)
            make.height.equalTo(self.textFieldHeight)
        }
        self.address.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.school.snp.bottom).offset(self.textFieldPlacing)
            make.height.equalTo(self.textFieldHeight)
        }
        self.yearOfAdmission.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.address.snp.bottom).offset(self.textFieldPlacing)
            make.height.equalTo(self.textFieldHeight)
        }
        self.yearsOfStudy.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.yearOfAdmission.snp.bottom).offset(self.textFieldPlacing)
            make.height.equalTo(self.textFieldHeight)
        }
        self.team.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.yearsOfStudy.snp.bottom).offset(self.textFieldPlacing)
            make.height.equalTo(self.textFieldHeight)
            make.bottom.equalToSuperview().priority(.medium)
        }
    }
    
    private func setupView() {
        self.view.addSubview(self.mainBound)
        
        mainBound.addSubview(self.scrollView)
        mainBound.addSubview(self.registerButton)
        
        scrollView.addSubview(self.bodyBound)

        bodyBound.addSubview(self.headerBound)
        bodyBound.addSubview(self.avatar)
        bodyBound.addSubview(self.name)
        bodyBound.addSubview(self.phoneNumber)
        bodyBound.addSubview(self.email)
        bodyBound.addSubview(self.birthDay)
        bodyBound.addSubview(self.identify)
        bodyBound.addSubview(self.password)
        bodyBound.addSubview(self.school)
        bodyBound.addSubview(self.address)
        bodyBound.addSubview(self.yearOfAdmission)
        bodyBound.addSubview(self.yearsOfStudy)
        bodyBound.addSubview(self.team)
        
        headerBound.addSubview(self.logoImageView)
        headerBound.addSubview(self.largeTitle)
        headerBound.addSubview(self.smallTitle)
        
        self.view.backgroundColor = UIColor.background
        
        self.setupTitle()
        self.setupBody()
        
        self.bodyBound.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        self.registerButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(self.padding)
            make.right.equalToSuperview().offset(-self.padding)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().offset(-20).priority(.medium)
        }
        
        self.scrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(self.padding)
            make.left.equalToSuperview().offset(self.padding)
            make.right.equalToSuperview().offset(-self.padding)
            make.bottom.equalTo(self.registerButton.snp.top).offset(-20)
        }
        
        self.mainBound.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
    
    private func setupEvents() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown(_:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupEvents()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let activeTextField = UIResponder.currentFirst() as? UITextField else { return }
        activeTextField.endEditing(true)
    }
    
    private var _loadingView: UIView?
    
    func showLoadingView() {
        self._loadingView = UIViewController.displaySpinner(onView: self.view)
    }
    
    func hideLoadingView() {
        guard let loadingView = self._loadingView else { return }
        UIViewController.removeSpinner(spinner: loadingView)
    }
    
    func registerSuccessful(for user: User) {
        let alertController = UIAlertController(title: "Thông báo", message: "Xin chúc mừng bạn, Đăng ký đã thành công!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { (_) in
            LoginManager.sharedInstance.user = user
            UIAppDelegate.shareInstance.showMainViewController()
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func registerFail() {
        let alertController = UIAlertController(title: "Thông báo", message: "Xin lỗi, đăng ký thất bại!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { (_) in
            
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

//MARK: - objc functionality
extension RegisterViewController {
    @objc private func registerTapped(_ sender: UIButton) {
        
        let errorAction = { () in
            let alert = UIAlertController(title: "Lỗi", message: "Bạn chưa nhập hết thông tin?", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "Ừ", style: UIAlertAction.Style.cancel, handler: nil)
            
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }

        
        guard let name = name.data as? String,
            let birthDay = birthDay.data as? Date,
            let phoneNumber = phoneNumber.data as? Int,
            let email = email.data as? String,
            let identify = identify.data as? Int,
            let school = school.data as? String,
            let address = address.data as? String,
            let yearOfAdmission = yearOfAdmission.data as? Int,
            let yearsOfStudy = yearsOfStudy.data as? Decimal,
            let team = team.data as? Team,
            let password = password.data as? String else {
                errorAction()
                return
        }
        
        
        let user = User(name: name,
                        birthDay: birthDay,
                        phoneNumber: "\(phoneNumber)",
                        email: email,
                        identify: "\(identify)",
                        school: school,
                        address: address,
                        yearOfAdmission: yearOfAdmission,
                        yearsOfStudy: Float(truncating: yearsOfStudy as NSNumber),
                        team: team,
                        imageUrl: "",
                        userType: UserType.member,
                        status: .notAuthentic,
                        password: password)
        
        
        self.presenter?.register(user: user, userImage: self.avatarImage)
    }
    
    @objc private func keyboardWasShown(_ notification: Notification) {
        guard let info = notification.userInfo,
            let keyboardFrameValue =
            info["UIKeyboardBoundsUserInfoKey"] as? NSValue
            else { return }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func imageTappedGesture(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                imagePicker.sourceType = .camera
                
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "photo library", style: .default, handler: { action in
                imagePicker.sourceType = .photoLibrary
                
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        self.present(alertController, animated: true, completion: nil)
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.avatar.image = selectedImage
            self.avatarImage = selectedImage
            dismiss(animated: true, completion: nil)
        }
    }
}
