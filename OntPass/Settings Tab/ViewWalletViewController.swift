//
//  ViewWalletViewController.swift
//  OntPass
//
//  Created by Ross Krasner on 12/8/18.
//  Copyright © 2018 Ryu. All rights reserved.
//

import UIKit

class ViewWalletViewController: UIViewController {

    @IBOutlet weak var addressStatic: UILabel!
    @IBOutlet weak var adress: UILabel!
    
    @IBOutlet weak var ontIDstatic: UILabel!
    @IBOutlet weak var ontID: UILabel!
    
    @IBOutlet weak var privateStatic: UILabel!
    @IBOutlet weak var privateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addressStatic.font = UIFont(name: boldFont, size: 24)
        
        adress.font = UIFont(name: regularFont, size: 17)
        adress.textColor = hexStringToUIColor(hex: "B1BAC4")
        
        ontIDstatic.font = UIFont(name: boldFont, size: 24)
        
        ontID.font = UIFont(name: regularFont, size: 17)
        ontID.textColor = hexStringToUIColor(hex: "B1BAC4")
        
        privateStatic.font = UIFont(name: boldFont, size: 24)
        
        privateLabel.font = UIFont(name: regularFont, size: 17)
        privateLabel.textColor = hexStringToUIColor(hex: "B1BAC4")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    


}
