//
//  LandingViewController.swift
//  OntPass
//
//  Created by Ross Krasner on 12/8/18.
//  Copyright © 2018 Ryu. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var signUpLabel: UILabel!

    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint! {
        didSet {
            logoTopConstraint.constant = screenHeight * 0.05
        }
    }
    @IBOutlet weak var logoBottomConstraint: NSLayoutConstraint! {
        didSet {
            logoBottomConstraint.constant = screenHeight * 0.03
        }
    }
    @IBOutlet weak var signInBottomConstraint: NSLayoutConstraint! {
        didSet {
            signInBottomConstraint.constant = screenHeight * 0.03
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attrs1 = [NSAttributedString.Key.font: UIFont(name: lightFont, size: 58),
                      NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let attrs2 = [NSAttributedString.Key.font: UIFont(name: regularFont, size: 58),
                      NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let string1 = "ONT"
        let string2 = "pass"
        
        let attributedString1 = NSMutableAttributedString(string: string1,
                                                          attributes: attrs1 as [NSAttributedString.Key: Any])
        
        let attributedString2 = NSMutableAttributedString(string: string2,
                                                          attributes: attrs2 as [NSAttributedString.Key: Any])
        
        attributedString1.append(attributedString2)
        
        mainLabel.attributedText = attributedString1
        
        signUpView.backgroundColor = hexStringToUIColor(hex: "2fa1bc")
        signUpView.layer.cornerRadius = 2.0
        
        signUpLabel.textColor = .white
        signUpLabel.font = UIFont(name: boldFont, size: 18)
        signUpLabel.text = "Create a wallet to get started"
        
        let attrs3 = [NSAttributedString.Key.font: UIFont(name: regularFont, size: 18),
                      NSAttributedString.Key.foregroundColor: UIColor.white]

        let string3 = "Or connect existing wallet"
        
        let attributedString3 = NSMutableAttributedString(string: string3,
                                                          attributes: attrs3 as [NSAttributedString.Key: Any])
        
        signInButton.setAttributedTitle(attributedString3, for: .normal)
        
    
        

        
    }
    
    @IBAction func signInClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "sign in", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = .white
        
    }
}
