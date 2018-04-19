//
//  ContactChangeViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by 최용석 on 2018. 4. 16..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit

class ContactChangeViewController: UIViewController {

    private var upperDesLabel: UILabel?
    private var tfDesLabel: UILabel?
    private var inputTextField: UITextField?
    private var getAuthButton: UIButton?
    
    private var movingHeightOfBtn: NSLayoutConstraint?
    private let keyFrameHeight: CGFloat = 216
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setNaviItem()
        setComponents()
        setLayout()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Set Nvaigation Item
    private func setNaviItem() {
        self.navigationItem.title = "연락처 변경"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "clearDismiss"), style: .done, target: self, action: #selector(popThis(_:)))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem()
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationItem.backBarButtonItem?.tintColor = UIColor(displayP3Red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
    }
    
    // MARK: - Set Components
    private func setComponents() {
        // Upper Description Label
        upperDesLabel = UILabel()
        upperDesLabel!.text = "새 휴대폰 번호를 입력하고 인증해주세요."
        upperDesLabel!.font = UIFont.systemFont(ofSize: 14)
        upperDesLabel!.textAlignment = .left
        upperDesLabel!.textColor = UIColor(displayP3Red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        
        self.view.addSubview(upperDesLabel!)
        upperDesLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        // TextField Description Label
        tfDesLabel = UILabel()
        tfDesLabel!.text = "휴대폰 번호"
        tfDesLabel!.font = UIFont.systemFont(ofSize: 12)
        tfDesLabel!.textAlignment = .left
        tfDesLabel!.textColor = UIColor(displayP3Red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        
        self.view.addSubview(tfDesLabel!)
        tfDesLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        // Input TextField
        inputTextField = UITextField()
        inputTextField!.delegate = self
        inputTextField!.placeholder = "전화번호를 입력하세요."
        inputTextField!.font = UIFont.systemFont(ofSize: 16)
        inputTextField!.textAlignment = .left
        inputTextField!.textColor = UIColor(displayP3Red: 48/255, green: 48/255, blue: 48/255, alpha: 1)
        inputTextField!.layer.borderWidth = 1
        inputTextField!.layer.borderColor = UIColor(displayP3Red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
        inputTextField!.layer.cornerRadius = 5
        inputTextField!.clipsToBounds = true
        inputTextField!.addTarget(self, action: #selector(moveBtnUp(_:)), for: .touchDown)
        
        self.view.addSubview(inputTextField!)
        inputTextField!.translatesAutoresizingMaskIntoConstraints = false
        
        // Action Button
        getAuthButton = UIButton()
        getAuthButton!.setTitle("문자로 인증코드 보내기", for: .normal)
        getAuthButton!.setTitleColor(UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        getAuthButton!.titleLabel!.font = UIFont.systemFont(ofSize: 16)
        getAuthButton!.titleLabel!.textAlignment = .center
        getAuthButton!.backgroundColor = UIColor(displayP3Red: 242/255, green: 92/255, blue: 98/255, alpha: 1)
        getAuthButton!.layer.cornerRadius = 10
        getAuthButton!.clipsToBounds = true
        getAuthButton!.addTarget(self, action: #selector(getAuthCode(_:)), for: .touchUpInside)
        
        self.view.addSubview(getAuthButton!)
        getAuthButton!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Set Layout of All Components
    private func setLayout() {
        guard let upperDesLabel = upperDesLabel,
            let tfDesLabel = tfDesLabel,
            let inputTextField = inputTextField,
            let getAuthButton = getAuthButton
            else { return }
        
        let safeGuide = self.view.safeAreaLayoutGuide
        
        // Upper Description Label
        upperDesLabel.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 20).isActive = true
        tfDesLabel.topAnchor.constraint(equalTo: upperDesLabel.bottomAnchor, constant: 34).isActive = true
        upperDesLabel.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 16).isActive = true
        safeGuide.trailingAnchor.constraint(equalTo: upperDesLabel.trailingAnchor, constant: 16).isActive = true
        
        // TextField Description Label
        inputTextField.topAnchor.constraint(equalTo: tfDesLabel.bottomAnchor, constant: 5).isActive = true
        tfDesLabel.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 24).isActive = true
        safeGuide.trailingAnchor.constraint(equalTo: tfDesLabel.trailingAnchor, constant: 24).isActive = true
        
        // Input TextField
        inputTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        inputTextField.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 24).isActive = true
        safeGuide.trailingAnchor.constraint(equalTo: inputTextField.trailingAnchor, constant: 24).isActive = true        
        
        // Action Button
        getAuthButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        getAuthButton.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 24).isActive = true
        safeGuide.trailingAnchor.constraint(equalTo: getAuthButton.trailingAnchor, constant: 24).isActive = true
        movingHeightOfBtn = safeGuide.bottomAnchor.constraint(equalTo: getAuthButton.bottomAnchor, constant: 24)
        movingHeightOfBtn!.isActive = true
    }
    
    // MARK: - Targets
    @objc func popThis(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func moveBtnUp(_ sender: UITextField) {
        guard let movingHeightOfBtn = movingHeightOfBtn else { return }
        movingHeightOfBtn.constant = 24 + self.keyFrameHeight  // height should be changed with the real one
    }
    
    @objc func getAuthCode(_ sender: UIButton) {
        let smsAuthVC = SMSAuthenticationViewController()
        self.navigationController?.pushViewController(smsAuthVC, animated: true)
    }
}

extension ContactChangeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let movingHeightOfBtn = movingHeightOfBtn else { return true }
        
        textField.resignFirstResponder()
        
        movingHeightOfBtn.constant = 24
        
        return true
    }
}