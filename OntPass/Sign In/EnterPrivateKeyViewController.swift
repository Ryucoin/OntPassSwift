//
//  EnterPrivateKeyViewController.swift
//  OntPass
//
//  Created by Ross Krasner on 12/8/18.
//  Copyright © 2018 Ryu. All rights reserved.
//

import UIKit

class EnterPrivateKeyViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorView: UIView! {
        didSet {
            let triangle = TriangleView(frame: CGRect(x: 5, y: -10, width: 25, height: 10), color: errorRedColor)
            triangle.backgroundColor = .black
            errorView.addSubview(triangle)
        }
    }
    @IBOutlet weak var erroLabel: UILabel!
    
    private var loginButton: UIButton!
    
    let ontController: OntController = OntController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField?.delegate = self
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont(name: regularFont, size: 14.0)!,
            NSAttributedString.Key.foregroundColor: hexStringToUIColor(hex: "979797") ]
        
        textField.attributedPlaceholder =
            NSAttributedString(string: "Private Key", attributes: placeholderAttributes)
        
        layoutTopOfKeyboard()
        
        errorView.isHidden = true
        
        mainLabel.font = UIFont(name: boldFont, size: 20)
        mainLabel.textColor = .white
        mainLabel.text = "Sign in with your private key"
        
        textField.textColor = .white
        textField.font = UIFont(name: boldFont, size: 14)
        
        errorView.backgroundColor = errorRedColor
        erroLabel.font = UIFont(name: regularFont, size: 14)
        erroLabel.text = "This is an error"
        erroLabel.textColor = .white
        
        textField.becomeFirstResponder()
        
    }
    
    private func layoutTopOfKeyboard() {
        let topOfKeyboard = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        topOfKeyboard.backgroundColor = nil
        
        let lineTopOfAcessory = UIView()
        lineTopOfAcessory.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 1)
        lineTopOfAcessory.backgroundColor = hexStringToUIColor(hex: "979797")
        textField.inputAccessoryView = topOfKeyboard
        topOfKeyboard.addSubview(lineTopOfAcessory)
        
        loginButton = UIButton(frame: CGRect(x: screenWidth - 100, y: 7, width: 80, height: 36))
        loginButton.setTitle("Log In", for: .normal)
        
        loginButton.backgroundColor = ontColor.withAlphaComponent(0.3)
        
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginButton.layer.cornerRadius = 2.0
        loginButton.isEnabled = false
        topOfKeyboard.addSubview(loginButton)
    }
    
    private func showError(withMessage errorMessage: String) {
        loginButton.backgroundColor = ontColor.withAlphaComponent(0.3)
        loginButton.isEnabled = false
        errorView.isHidden = false
        
        let errorMessageAttributedString = NSMutableAttributedString(string: errorMessage)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8 // Whatever line spacing you want in points
        errorMessageAttributedString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: (errorMessageAttributedString.string as NSString).range(of: errorMessage))
        erroLabel.attributedText = errorMessageAttributedString
    }
    
    @objc func loginTapped() {
        let success = ontController.walletLogin(for: textField.text!)
        if success {
            performSegue(withIdentifier: "logged in", sender: self)
            
        } else {
            showError(withMessage: "Private Key Incorrect")
        }
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        errorView.isHidden = true
        errorView.isHidden = true
        
        if !text.isEmpty {
            loginButton.isEnabled = true
            loginButton.backgroundColor = ontColor
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = ontColor.withAlphaComponent(0.3)
        }
        
        return true
    }

}
