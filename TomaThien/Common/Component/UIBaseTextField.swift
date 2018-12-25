//
//  UIBaseTextField.swift
//  TomaThien
//
//  Created by Mr Tuyen Nguyen Quoc Tuyen on 12/23/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit


enum InputType {
    case textInput
    case numberInput
    case decimalInput
    case emailInput
    case dateInput
    case teamInput
}

class UIBaseTextField: UIView {
    public var inputType = InputType.textInput {
        didSet {
            switch self.inputType {
            case .textInput:
                break
            case .numberInput:
                self._textField.keyboardType = UIKeyboardType.numberPad
            case .decimalInput:
                self._textField.keyboardType = UIKeyboardType.decimalPad
            case .emailInput:
                self._textField.keyboardType = UIKeyboardType.emailAddress
            case .dateInput:
                self._textField.inputView = self._datePicker
            case .teamInput:
                self._textField.inputView = self._teamPicker.view
            }
        }
    }
    
    public var isSecureTextEntry: Bool = false {
        didSet {
            self._textField.isSecureTextEntry = self.isSecureTextEntry
        }
    }
    
    public var textColor: UIColor? = UIColor.black {
        didSet {
            self._textField.textColor = self.textColor
        }
    }
    
    public var placeholder: String? {
        didSet {
            self._textField.placeholder = self.placeholder
            self._titleLabel.text = self.placeholder
        }
    }
    
    public var font: UIFont? = UIFont.systemFont(ofSize: 16) {
        didSet {
            self._textField.font = self.font
        }
    }
    
    public var borderColor: CGColor? = UIColor.appBase.cgColor {
        didSet {
            self._borderView.layer.borderColor = self.borderColor
        }
    }
    
    public var titleColor: UIColor? = UIColor.appBase {
        didSet {
            self._titleLabel.textColor = self.titleColor
        }
    }
    
    public var underLineColor: UIColor = UIColor.appBase {
        didSet {
            self._underLine.backgroundColor = self.underLineColor
        }
    }
    
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 10) {
        didSet {
            self._titleLabel.font = self.titleFont
        }
    }
    
    public var borderCornerRadius: CGFloat = 5 {
        didSet {
            self._borderView.layer.cornerRadius = self.borderCornerRadius
        }
    }
    
    public var borderWidth: CGFloat = 1 {
        didSet {
            self._borderView.layer.borderWidth = self.borderWidth
        }
    }
    
    public var data: Any {
        guard let text = self._textField.text else { return "" }
        switch self.inputType {
        case .textInput:
            return text
        case .numberInput:
            return Int(text) ?? 0
        case .decimalInput:
            return Decimal(string: text) ?? 0
        case .emailInput:
            return text
        case .dateInput:
            return self._datePicker.date
        case .teamInput:
            return self._currentTeam
        }
    }
    
    private lazy var _textField: UITextField = {
        let textField = UITextField()
        textField.textColor = self.textColor
        textField.placeholder = self.placeholder
        textField.font = self.font
        textField.delegate = self
        return textField
    }()
    
    private lazy var _borderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.appBase.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    private lazy var _titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.appBase
        label.backgroundColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "Edit"
        return label
    }()
    
    private lazy var _underLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        return view
    }()
    
    private var _isEditing: Bool = false {
        didSet {
            self._textField.placeholder = self._isEditing ? "" : self.placeholder
            UIView.animate(withDuration: 0.2) {
                self._underLine.alpha = self._isEditing ? 0 : 1
                self._borderView.alpha = self._isEditing ? 1 : 0
                self._titleLabel.alpha = self._isEditing ? 1 : 0
            }
        }
    }
    
    private lazy var _datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.backgroundColor = UIColor.white
        picker.datePickerMode = UIDatePicker.Mode.date
        picker.addTarget(self, action: #selector(calendarDidChange(_:)), for: UIControl.Event.valueChanged)
        return picker
    }()
    
    private lazy var _teamPicker: TeamListViewController = {
        let picker = TeamListViewController(currentTeam: Team(id: 1))
        picker.view.frame.size.width = UIScreen.main.bounds.size.width
        picker.view.frame.size.height = 500
        picker.delegate = self
        return picker
    }()
    
    private var _toolBarInputView: UIToolbar = {
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                          target: nil,
                                          action: nil)
        let doneButton = UIBarButtonItem(title: "Xong",
                                         style: UIBarButtonItem.Style.done,
                                         target: self,
                                         action: #selector(doneInputView(_:)))
        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.backgroundColor = UIColor.white
        
        return toolbar
    }()
    
    //MARK: - private properties
    private var _currentTeam: Team = Team(id: 1) {
        didSet {
            self._textField.text = self._currentTeam.name
        }
    }
    
    private func setupView() {
        self.addSubview(self._borderView)
        self.addSubview(self._titleLabel)
        self.addSubview(self._underLine)
        self.addSubview(self._textField)
        
        self._underLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview()
        }
        
        self._borderView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
        
        self._titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview()
            make.width.height.greaterThanOrEqualTo(0)
        }
        
        self._textField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }
        
        self._textField.inputAccessoryView = self._toolBarInputView
        
        self._isEditing = false
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.setupView()
    }
    
    
    override func endEditing(_ force: Bool) -> Bool {
        self._textField.endEditing(force)
        return super.endEditing(force)
    }
}

extension UIBaseTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self._isEditing = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self._isEditing = false
    }
}

extension UIBaseTextField: TeamListDelegate {
    func teamListView(didSelect userTeam: Team) {
        self._currentTeam = userTeam
    }
}

extension UIBaseTextField {
    @objc func doneInputView(_ sender: UIBarButtonItem) {
        if self.inputType == .dateInput {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.dateFormat = "dd/MM/yyyy"
            self._textField.text = dateFormatter.string(from: self._datePicker.date)
        }
        
        self._textField.endEditing(true)
    }
    
    @objc func calendarDidChange(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self._textField.text = dateFormatter.string(from: sender.date)
    }
}
