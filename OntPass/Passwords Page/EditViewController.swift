//
//  EditViewController.swift
//  OntPass
//
//  Created by Ross Krasner on 12/8/18.
//  Copyright © 2018 Ryu. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITextFieldDelegate {
    
    var saveButton = UIButton()
    
    var passwordTextView = UITextField()
    var urlTextView = UITextField()
    var usernameTextView = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        urlTextView.becomeFirstResponder()
        
        var topSpace : CGFloat = 0
        
        if #available(iOS 11.0, *) {
            topSpace = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
        }
        
        let cancelButton = UIButton()
        let title = "Cancel"
        let attributedTitleAttribute = [ NSAttributedString.Key.font: UIFont(name: boldFont, size: 16)!,
                                         NSAttributedString.Key.foregroundColor: hexStringToUIColor(hex: "#4A90E2")]
        let attributedTitle = NSAttributedString(string: title, attributes: attributedTitleAttribute)
        cancelButton.setAttributedTitle(attributedTitle, for: .normal)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cancelButton)
    
        cancelButton.rightAnchor.constraint(
            equalTo: view.rightAnchor,
            constant: -10).isActive = true
        cancelButton.topAnchor.constraint(
            equalTo: view.topAnchor,
            constant: 10 + topSpace).isActive = true
        
        let urlLabel = UILabel()
        urlLabel.text = "URL"
        urlLabel.translatesAutoresizingMaskIntoConstraints = false
        urlLabel.font = UIFont(name: boldFont, size: 17)
        urlLabel.textColor = .black
        
        view.addSubview(urlLabel)
        
        urlLabel.leftAnchor.constraint(
            equalTo: view.leftAnchor,
            constant: 25).isActive = true
        urlLabel.topAnchor.constraint(
            equalTo: view.topAnchor,
            constant: 40 + topSpace).isActive = true
        
        urlTextView.translatesAutoresizingMaskIntoConstraints = false
        urlTextView.font = UIFont(name: boldFont, size: 14)
        urlTextView.textColor = hexStringToUIColor(hex: "555555")
        urlTextView.text = passwordForDetail?.url
        urlTextView.delegate = self
        urlTextView.autocorrectionType = .no
        
        view.addSubview(urlTextView)
        
        urlTextView.leftAnchor.constraint(
            equalTo: urlLabel.leftAnchor ).isActive = true
        urlTextView.topAnchor.constraint(
            equalTo: urlLabel.bottomAnchor,
            constant: 7).isActive = true
        urlTextView.rightAnchor.constraint(
            equalTo: view.rightAnchor,
            constant: 25).isActive = true
        urlTextView.heightAnchor.constraint(
            equalToConstant: 30).isActive = true
        
        let line1 = UIView()
        
        line1.backgroundColor = hexStringToUIColor(hex: "D8D8D8")
        line1.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(line1)
        
        line1.leftAnchor.constraint(
            equalTo: urlLabel.leftAnchor).isActive = true
        line1.topAnchor.constraint(
            equalTo: urlTextView.bottomAnchor,
            constant: 10).isActive = true
        line1.widthAnchor.constraint(
            equalToConstant: screenWidth).isActive = true
        line1.heightAnchor.constraint(
            equalToConstant: 1).isActive = true
     
        
        let usernameLabel = UILabel()
        
        usernameLabel.text = "Username"
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.font = UIFont(name: boldFont, size: 17)
        usernameLabel.textColor = .black
        
        view.addSubview(usernameLabel)
        
        usernameLabel.leftAnchor.constraint(
            equalTo: view.leftAnchor,
            constant: 25).isActive = true
        usernameLabel.topAnchor.constraint(
            equalTo: urlTextView.bottomAnchor,
            constant: 30).isActive = true
        
        
        
        usernameTextView.translatesAutoresizingMaskIntoConstraints = false
        usernameTextView.font = UIFont(name: boldFont, size: 14)
        usernameTextView.textColor = hexStringToUIColor(hex: "555555")
        usernameTextView.text = passwordForDetail?.username
        usernameTextView.delegate = self
        usernameTextView.autocorrectionType = .no
        
        
        view.addSubview(usernameTextView)
        
        usernameTextView.leftAnchor.constraint(
            equalTo: urlLabel.leftAnchor ).isActive = true
        usernameTextView.topAnchor.constraint(
            equalTo: usernameLabel.bottomAnchor,
            constant: 7).isActive = true
        usernameTextView.rightAnchor.constraint(
            equalTo: view.rightAnchor,
            constant: 25).isActive = true
        usernameTextView.heightAnchor.constraint(
            equalToConstant: 30).isActive = true
        
        let passwordLabel = UILabel()
        passwordLabel.text = "Password"
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.font = UIFont(name: boldFont, size: 17)
        passwordLabel.textColor = .black
        
        let line2 = UIView()
        
        line2.backgroundColor = hexStringToUIColor(hex: "D8D8D8")
        line2.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(line2)
        
        line2.leftAnchor.constraint(
            equalTo: urlLabel.leftAnchor).isActive = true
        line2.topAnchor.constraint(
            equalTo: usernameTextView.bottomAnchor,
            constant: 10).isActive = true
        line2.widthAnchor.constraint(
            equalToConstant: screenWidth).isActive = true
        line2.heightAnchor.constraint(
            equalToConstant: 1).isActive = true
        
        view.addSubview(passwordLabel)
        
        passwordLabel.leftAnchor.constraint(
            equalTo: view.leftAnchor,
            constant: 25).isActive = true
        passwordLabel.topAnchor.constraint(
            equalTo: usernameTextView.bottomAnchor,
            constant: 30).isActive = true
        

        
        passwordTextView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextView.font = UIFont(name: boldFont, size: 14)
        passwordTextView.textColor = hexStringToUIColor(hex: "555555")
        passwordTextView.text = passwordForDetail?.password
        passwordTextView.delegate = self
        passwordTextView.autocorrectionType = .no
        
        view.addSubview(passwordTextView)
        
        passwordTextView.leftAnchor.constraint(
            equalTo: urlLabel.leftAnchor ).isActive = true
        passwordTextView.topAnchor.constraint(
            equalTo: passwordLabel.bottomAnchor,
            constant: 7).isActive = true
        passwordTextView.rightAnchor.constraint(
            equalTo: view.rightAnchor,
            constant: 25).isActive = true
        passwordTextView.heightAnchor.constraint(
            equalToConstant: 30).isActive = true
        
        
        
    layoutTopOfKeyboard()

    }
    
    private func layoutTopOfKeyboard() {
        let topOfKeyboard = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        topOfKeyboard.backgroundColor = nil
        
        let lineTopOfAcessory = UIView()
        lineTopOfAcessory.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 1)
        lineTopOfAcessory.backgroundColor = hexStringToUIColor(hex: "979797")
        passwordTextView.inputAccessoryView = topOfKeyboard
        urlTextView.inputAccessoryView = topOfKeyboard
        usernameTextView.inputAccessoryView = topOfKeyboard
        topOfKeyboard.addSubview(lineTopOfAcessory)
        
        saveButton = UIButton(frame: CGRect(x: screenWidth - 100, y: 7, width: 80, height: 36))
        saveButton.setTitle("Save", for: .normal)
        
        saveButton.backgroundColor = ontColor.withAlphaComponent(0.3)
        saveButton.isEnabled = false
        
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        saveButton.layer.cornerRadius = 2.0
        
        topOfKeyboard.addSubview(saveButton)
    }
    
    @objc func saveTapped() {
        let alert = UIAlertController(title: "Are you sure you want to edit this entry?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes, Save Entry", style: .default, handler: { action in
            print("Yes Edit Entry)")
            print("Username: \(self.usernameTextView.text)")
            print("URL: \(self.urlTextView.text)")
            print("Password: \(self.passwordTextView.text)")
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            print("Cancel")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @objc func cancelTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTapped()
        return false
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        saveButton.backgroundColor = ontColor
        saveButton.isEnabled = true
        
        return true
    }

}
