//
//  LoginViewController.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/31/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController, LoginViewProtocol {
    var presenter: LoginPresenterProtocol?
    private let textFieldHeight: CGFloat = 50
    //MARK: - View Properties
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
    private lazy var createAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Chưa có tài khoản?"
        label.font = UIFont.sfuiMedium()
        label.textColor = .black
        return label
    }()
    private lazy var userNameTextField: UIBaseTextField = {
        let textField = UIBaseTextField()
        textField.placeholder = "Nhập email nhé"
        textField.inputType = InputType.emailInput
        return textField
    }()
    private lazy var passwordTextField: UIBaseTextField = {
        let textField = UIBaseTextField()
        textField.placeholder = "Nhập mật khẩu nhé"
        textField.inputType = InputType.textInput
        textField.isSecureTextEntry = true
        return textField
    }()
    private lazy var forgotPasswordButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Quên mật khẩu?", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.sfuiMedium()
        btn.addTarget(self, action: #selector(forgotPasswordTapped(_:)), for: .touchUpInside)
        return btn
    }()
    private lazy var loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Đăng nhập", for: .normal)
        btn.layer.cornerRadius = 3
        btn.titleLabel?.textColor = .white
        btn.titleLabel?.font = UIFont.sfuiMedium()
        btn.backgroundColor = UIColor.appBase
        btn.addTarget(self, action: #selector(loginTapped(_:)), for: .touchUpInside)
        return btn
    }()
    private lazy var registerButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Đăng ký", for: .normal)
        btn.setTitleColor(.appBase, for: .normal)
        btn.titleLabel?.font = UIFont.sfuiMedium()
        btn.addTarget(self, action: #selector(registerTapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var boundTitle: UIView = {
        let bound = UIView()
        bound.addSubview(self.logoImageView)
        bound.addSubview(self.largeTitle)
        bound.addSubview(self.smallTitle)
        return bound
    }()
    private lazy var boundTextField: UIView = {
        let bound = UIView()
        bound.addSubview(self.userNameTextField)
        bound.addSubview(self.passwordTextField)
        return bound
    }()
    private lazy var boundLoginAction: UIView = {
        let bound = UIView()
        bound.addSubview(self.forgotPasswordButton)
        bound.addSubview(self.loginButton)
        return bound
    }()
    private lazy var boundRegister: UIView = {
        let bound = UIView()
        bound.addSubview(self.createAccountLabel)
        bound.addSubview(self.registerButton)
        return bound
    }()
    private lazy var mainBound: UIView = {
        let bound = UIView()
        bound.addSubview(self.boundTitle)
        bound.addSubview(self.boundTextField)
        bound.addSubview(self.boundLoginAction)
        bound.backgroundColor = .white
        bound.layer.cornerRadius = 5
        bound.layer.masksToBounds = false
        bound.layer.shadowColor = UIColor.black.cgColor
        bound.layer.shadowOpacity = 0.5
        bound.layer.shadowOffset = .zero
        bound.layer.shadowRadius = 1
        return bound
    }()
    
    //MARK: - Setup view functions
    private func setupView() {
        self.view.backgroundColor = UIColor.background
        self.view.addSubview(self.mainBound)
        self.view.addSubview(self.boundRegister)
        
        self.setupTitle()
        self.setupTextField()
        self.setupLoginAction()
        self.setupRegister()
        
        self.boundTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        self.boundTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.boundTitle.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        self.boundLoginAction.snp.makeConstraints { (make) in
            make.top.equalTo(self.boundTextField.snp.bottom).offset(20)
            make.width.equalTo(self.boundTextField)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10).priority(.medium)
        }
        self.mainBound.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        self.boundRegister.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
    }
   
    
    private func setupTitle() {
        self.logoImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(60)
            make.centerX.equalToSuperview()
        }
        self.largeTitle.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.logoImageView.snp.bottom).offset(30)
            make.height.greaterThanOrEqualTo(0)
        }
        self.smallTitle.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.largeTitle.snp.bottom).offset(30)
            make.bottom.equalToSuperview().priority(.medium)
        }
    }
    
    private func setupTextField() {
        self.userNameTextField.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(self.textFieldHeight)
        }
        self.passwordTextField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(self.textFieldHeight)
            make.top.equalTo(self.userNameTextField.snp.bottom).offset(10)
            make.bottom.equalToSuperview().priority(.medium)
        }
    }
    
    private func setupLoginAction() {
        self.loginButton.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(40)
        }
        self.forgotPasswordButton.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.top.equalTo(self.loginButton.snp.bottom).offset(20)
            make.width.greaterThanOrEqualTo(0)
        }
    }
    
    private func setupRegister() {
        self.createAccountLabel.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.greaterThanOrEqualTo(0)
        }
        
        self.registerButton.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().priority(.medium)
            make.width.greaterThanOrEqualTo(0)
            make.left.equalTo(self.createAccountLabel.snp.right).offset(20)
        }
    }
    
    
    //MARK: - Variable
    private let disposeBag = DisposeBag()
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupEvent()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupEvent() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func registerTapped(_ sender: UIButton) {
        self.presenter?.showRegisterView(from: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let _ = self.userNameTextField.endEditing(true)
        let _ = self.passwordTextField.endEditing(true)
    }
    
    func loginSuccessful(user: User) {
        LoginManager.sharedInstance.user = user
        UIAppDelegate.shareInstance.showMainViewController()
    }
    
    func loginFault(message: String) {
        let alert = UIAlertController(title: "Lỗi", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension LoginViewController {
    @objc private func keyboardWasShown(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            guard
                let info = notification.userInfo,
                let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue,
                let activeTextField = UIResponder.currentFirst() as? UITextField,
                let superActiveTextField = activeTextField.superview
                else { return }
            
            let padding: CGFloat = 5
            let originY = self.view.convert(activeTextField.frame, from: superActiveTextField).origin.y
            let height = self.view.frame.height - originY - activeTextField.frame.height - padding
            let keyboardHeight = keyboardFrameValue.cgRectValue.size.height
            let gap = keyboardHeight - height
            
            if gap > 0 {
                self.mainBound.transform = CGAffineTransform(translationX: 0, y: -gap)
            }
            
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.mainBound.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    @objc private func loginTapped(_ sender: UIButton) {
        
        let errorAction = { () in
            let alert = UIAlertController(title: "Lỗi", message: "Bạn chưa nhập hết thông tin?", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        guard let userName = self.userNameTextField.data as? String,
            let password = self.passwordTextField.data as? String,
            !userName.isEmpty,
            !password.isEmpty else {
                errorAction()
                return
        }
        self.presenter?.login(userName: userName, password: password)
//        let user = User(name: "Nguyễn Quốc Tuyến",
//                        birthDay: Date(),
//                        phoneNumber: "",
//                        email: "",
//                        identify: "184313135",
//                        school: "",
//                        address: "",
//                        yearOfAdmission: 2015,
//                        yearsOfStudy: 4,
//                        team: Team(id: 8),
//                        imageUrl: "",
//                        userType: .admin,
//                        status: .authentic)
//        LoginManager.sharedInstance.user = user
//        UIAppDelegate.shareInstance.showMainViewController(user: user)
    }
    
    @objc private func forgotPasswordTapped(_ sender: UIButton) {
        
    }
}
