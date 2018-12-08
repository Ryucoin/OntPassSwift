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
    let menuHeight: CGFloat = 50 * 6
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
        titleView.backgroundColor = UIColor.yellow.withAlphaComponent(0.3)
        menuView.addSubview(titleView)
        
        for menutItem in 0..<6 {
            
            let button = UIButton(frame: CGRect(x: 0, y: menutItem * 50, width: Int(screenWidth), height: 50))
            button.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
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
        print("goToWebsiteSelected")
    }
    @objc func copyUsername() {
        print("copyUsername")
    }
    @objc func copyPassword() {
        print("copyPassword")
    }
    @objc func editPassword() {
        print("editPassword")
    }
    @objc func showPassword() {
        print("showPassword")
    }
    @objc func deletePassword() {
        print("deletePassword")
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
