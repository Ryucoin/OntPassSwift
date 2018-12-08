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
    
    let searchController = UISearchController(searchResultsController: nil)
    
    struct Password {
        var username: String?
        var password: String?
        var url: String?
    }
    
    var passwords = [Password(username: "rosskrasner", password: "pass123", url: "https://google.com"), Password(username: "krasner.ross@gmail.com", password: "pfa23ss!123", url: "https://facebook.com")]
    
    var filteredPasswords = [Password]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordsTable.backgroundColor = .black
        passwordsTable.tableFooterView = UIView()
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Passwords"
        navigationItem.searchController = searchController
        definesPresentationContext = true
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
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredPasswords = passwords.filter({( pw : Password) -> Bool in
            if let url = pw.url {
                print(url.lowercased().contains(searchText.lowercased()))
                return url.lowercased().contains(searchText.lowercased())
            }
            return false
        })
        
        passwordsTable.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredPasswords.count
        }
        
        return passwords.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = PasswordDetailsViewController()
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "passwordCell", for: indexPath)
        if let passwordCell = cell as? PasswordTableViewCell {
            
            passwordCell.websiteURL.font = UIFont(name: regularFont, size: 17)
            passwordCell.websiteURL.textColor = .white
            
            
            passwordCell.usernameLabel.font = UIFont(name: regularFont, size: 17)
            passwordCell.usernameLabel.textColor = hexStringToUIColor(hex: "B1BAC4")
            
            
            
            
            var link = ""
            
            if isFiltering() {
                passwordCell.websiteURL.text = filteredPasswords[indexPath.row].url
                passwordCell.usernameLabel.text = filteredPasswords[indexPath.row].username
                link = filteredPasswords[indexPath.row].url ?? ""
            } else {
                passwordCell.websiteURL.text = passwords[indexPath.row].url
                passwordCell.usernameLabel.text = passwords[indexPath.row].username
                link = passwords[indexPath.row].url ?? ""
            }
            
            
            link.append("/apple-touch-icon.png")
            print(link)
            URLSession.shared.dataTask(with: NSURL(string: link)! as URL, completionHandler: { (data, response, error) -> Void in
                
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 89
    }
    


}

extension PasswordsViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

