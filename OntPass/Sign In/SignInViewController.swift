//
//  SignInViewController.swift
//  OntPass
//
//  Created by Ross Krasner on 12/8/18.
//  Copyright © 2018 Ryu. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var scanView: UIView!
    @IBOutlet weak var scanImage: UIImageView!
    @IBOutlet weak var scanTopLabel: UILabel!
    @IBOutlet weak var scanBottomLabel: UILabel!
    
    @IBOutlet weak var fakePrivateKeyLabel: UILabel!
    @IBOutlet weak var fakeCursorView: UIView!
    @IBOutlet weak var bottomFakePrivateKeyView: UIView!
    @IBOutlet weak var enterTopLabel: UILabel!
    @IBOutlet weak var enterbottomLabel: UILabel!
    @IBOutlet weak var enterView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanTopLabel.text = "Scan"
        scanTopLabel.font = UIFont(name: boldFont, size: 20)
        scanTopLabel.textColor = .black
        
        scanBottomLabel.text = "Private Key"
        scanBottomLabel.font = UIFont(name: regularFont, size: 17)
        scanBottomLabel.textColor = hexStringToUIColor(hex: "555555")
        
        enterTopLabel.text = "Enter"
        enterTopLabel.font = UIFont(name: boldFont, size: 20)
        enterTopLabel.textColor = .black
        
        enterbottomLabel.text = "Private Key"
        enterbottomLabel.font = UIFont(name: regularFont, size: 17)
        enterbottomLabel.textColor = hexStringToUIColor(hex: "555555")
        
        scanView.layer.cornerRadius = 14.0
        scanView.layer.borderWidth = 1.0
        scanView.layer.borderColor = UIColor.clear.cgColor
        
        scanView.layer.shadowColor = UIColor.black.cgColor
        scanView.layer.shadowOpacity = 0.5
        scanView.layer.shadowRadius = 10.0
        scanView.layer.masksToBounds = false
        
        enterView.layer.cornerRadius = 14.0
        enterView.layer.borderWidth = 1.0
        enterView.layer.borderColor = UIColor.clear.cgColor
        
        enterView.layer.shadowColor = UIColor.black.cgColor
        enterView.layer.shadowOpacity = 0.5
        enterView.layer.shadowRadius = 10.0
        enterView.layer.masksToBounds = false
        
        fakeCursorView.makeCircular()
        
        topLabel.text = "Choose how to sign in"
        topLabel.font = UIFont(name: boldFont, size: 30)
        topLabel.textColor = .black
        
        let enterTap = UITapGestureRecognizer(target: self, action: #selector(enterTapped))
        enterView.addGestureRecognizer(enterTap)
        
        let scanTap = UITapGestureRecognizer(target: self, action: #selector(scanTapped))
        scanView.addGestureRecognizer(scanTap)
        
    }
    
    
    @objc func enterTapped() {
        print("enter Tapped")
    }
    @objc func scanTapped() {
       performSegue(withIdentifier: "scan private", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = .white
        
    }
    
    @IBOutlet weak var scanLeftConstraint: NSLayoutConstraint! {
        didSet {
            if deviceIsiPhone5s {
                scanLeftConstraint.constant = screenWidth * 0.04
            } else {
                scanLeftConstraint.constant = screenWidth * 0.072
            }

        }
    }
    @IBOutlet weak var enterRightConstraint: NSLayoutConstraint! {
        didSet {
            if deviceIsiPhone5s {
                enterRightConstraint.constant = screenWidth * 0.04
            } else {
                enterRightConstraint.constant = screenWidth * 0.072
            }

        }
    }
    
    
}
