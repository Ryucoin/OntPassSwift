//
//  PasswordDetailsViewController.swift
//  OntPass
//
//  Created by Ross Krasner on 12/8/18.
//  Copyright © 2018 Ryu. All rights reserved.
//

import UIKit

class PasswordDetailsViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    lazy var backdropView: UIView = {
        let bdView = UIView(frame: self.view.bounds)
        bdView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return bdView
    }()
    
    let menuView = UIView()
    let menuHeight: CGFloat = 50 * 7
    var isPresenting = false
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        view.addSubview(backdropView)
        view.addSubview(menuView)
        layoutMenuButtons()
        
        menuView.backgroundColor = .white
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.heightAnchor.constraint(equalToConstant: menuHeight).isActive = true
        menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PasswordDetailsViewController.handleTap))
        backdropView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    func layoutMenuButtons() {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 50))
        menuView.addSubview(titleView)
        
        let sitLabel = UILabel(frame: CGRect(x: 60, y: 2, width: screenWidth - 50, height: 50))
        sitLabel.font = UIFont(name: regularFont, size: 17)
        
        if let siteName = passwordForDetail?.url {
            sitLabel.text = siteName
        }
        titleView.addSubview(sitLabel)
        
        let icon = UIImageView(frame: CGRect(x: 15, y: 10, width: 30, height: 30))
        icon.contentMode = .scaleAspectFit
        
        if let link = passwordForDetail?.url {
            var imgLink = link
            imgLink.append("/apple-touch-icon.png")
            
            URLSession.shared.dataTask(with: NSURL(string: imgLink)! as URL, completionHandler: { (data, response, error) -> Void in
                
                if error != nil {
                    print(error ?? "error")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    if let image = UIImage(data: data!) {
                        icon.image = image
                        icon.makeCircular()
                    } else {
                        icon.image = UIImage(named: "placeholder")
                        icon.makeCircular()
                    }
                    
                })
                
            }).resume()
            titleView.addSubview(icon)
        }
        
        for menutItem in 0..<6 {
            
            let button = UIButton(frame: CGRect(x: 0, y: 50 + menutItem * 50, width: Int(screenWidth), height: 50))
            switch menutItem {
            case 0:
                button.addTarget(self, action: #selector(goToWebsiteSelected), for: UIControl.Event.touchUpInside)
            case 1:
                button.addTarget(self, action: #selector(copyUsername), for: UIControl.Event.touchUpInside)
            case 2:
                button.addTarget(self, action: #selector(copyPassword), for: UIControl.Event.touchUpInside)
            case 3:
                button.addTarget(self, action: #selector(editPassword), for: UIControl.Event.touchUpInside)
            case 4:
                button.addTarget(self, action: #selector(showPassword), for: UIControl.Event.touchUpInside)
            case 5:
                button.addTarget(self, action: #selector(deletePassword), for: UIControl.Event.touchUpInside)
            default:
                print("default")
            }
            
            menuView.addSubview(button)
            let label = UILabel(frame: CGRect(x: 20, y: 13, width: 300, height: 25))
            let menuOptions = ["Go to website","Copy username","Copy password", "Edit", "Show password", "Delete"]
            label.text = menuOptions[menutItem]
            label.font = UIFont(name: boldFont, size: 17)
            button.addSubview(label)
            
        }
    }
    
    @objc func goToWebsiteSelected() {
        let link = passwordForDetail?.url
        guard let url = URL(string: link ?? "") else { return }
        UIApplication.shared.open(url)
    }
    @objc func copyUsername() {
        if let username = passwordForDetail?.username {
            UIPasteboard.general.string = username
        }
    }
    @objc func copyPassword() {
        if let password = passwordForDetail?.password {
            UIPasteboard.general.string = password
        }
    }
    @objc func editPassword() {
        let vc = EditViewController()
        self.present(vc, animated: true, completion: nil)
    }
    @objc func showPassword() {

        //1. Create the alert controller.
        let alert = UIAlertController(title: "Your Password is:", message: "", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.isEnabled = false
            textField.textAlignment = .center
            textField.font = UIFont(name: boldFont, size: 20)
            
            let redFont = [NSAttributedString.Key.foregroundColor: UIColor.red]
            
            let passwordString = passwordForDetail?.password
            
            let myAttributedString = NSMutableAttributedString()
            if let unicodePass = passwordString?.unicodeScalars {
                for letter in unicodePass {
                    let myLetter : NSAttributedString
                    if CharacterSet.decimalDigits.contains(letter) {
                        myLetter = NSAttributedString(string: "\(letter)", attributes: redFont)
                    } else {
                        myLetter = NSAttributedString(string: "\(letter)")
                    }
                    myAttributedString.append(myLetter)
                }
                
                textField.attributedText = myAttributedString
            }
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            textField?.isEnabled = false
            textField?.text = passwordForDetail?.password
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
        
    }
    @objc func deletePassword() {
        let alert = UIAlertController(title: "Are you sure you want to delete your password?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete Password", style: .destructive, handler: { action in
                print("Delete Password for url: \(passwordForDetail?.url)")
                self.dismiss(animated: true, completion: nil)
            }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            print("Cancel")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

extension PasswordDetailsViewController: UIViewControllerAnimatedTransitioning {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        guard let toVC = toViewController else { return }
        isPresenting = !isPresenting
        
        if isPresenting == true {
            containerView.addSubview(toVC.view)
            
            menuView.frame.origin.y += menuHeight
            backdropView.alpha = 0
            
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
                self.menuView.frame.origin.y -= self.menuHeight
                self.backdropView.alpha = 1
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
                self.menuView.frame.origin.y += self.menuHeight
                self.backdropView.alpha = 0
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        }
    }
}
