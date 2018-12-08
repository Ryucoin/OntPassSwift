//
//  PasswordsViewController.swift
//  OntPass
//
//  Created by Ross Krasner on 12/8/18.
//  Copyright © 2018 Ryu. All rights reserved.
//

import UIKit

class PasswordsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var passwordsTable: UITableView! {
        didSet {
            passwordsTable.dataSource = self
            passwordsTable.delegate = self
        }
    }
    
    struct Password {
        var username: String?
        var password: String?
        var url: String?
    }
    
    var passwords = [Password(username: "rosskrasner", password: "pass123", url: "https://google.com"), Password(username: "krasner.ross@gmail.com", password: "pfa23ss!123", url: "https://facebook.com")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordsTable.backgroundColor = .black
        passwordsTable.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        self.navigationItem.hidesBackButton = true
        navigationItem.hidesBackButton = true
        tabBarController?.navigationController?.navigationItem.hidesBackButton = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navigationTitleFont]
        self.navigationItem.title = "Passwords"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passwords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "passwordCell", for: indexPath)
        if let passwordCell = cell as? PasswordTableViewCell {
            
            passwordCell.websiteURL.font = UIFont(name: regularFont, size: 17)
            passwordCell.websiteURL.textColor = .white
            
            
            passwordCell.usernameLabel.font = UIFont(name: regularFont, size: 17)
            passwordCell.usernameLabel.textColor = hexStringToUIColor(hex: "B1BAC4")
            
            
            passwordCell.websiteURL.text = passwords[indexPath.row].url
            passwordCell.usernameLabel.text = passwords[indexPath.row].username
            
            var link = passwords[indexPath.row].url
            link?.append("/apple-touch-icon.png")
            print(link ?? "No Link")
            if let urlString = link {
                URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
                    
                    if error != nil {
                        print(error ?? "error")
                        return
                    }
                    DispatchQueue.main.async(execute: { () -> Void in
                        if let image = UIImage(data: data!) {
                            passwordCell.imageIcon.image = image
                            passwordCell.imageIcon.makeCircular()
                        } else {
                            passwordCell.imageIcon.image = UIImage(named: "placeholder")
                            passwordCell.imageIcon.makeCircular()
                        }
                        
                    })
                    
                }).resume()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 89
    }
    


}
