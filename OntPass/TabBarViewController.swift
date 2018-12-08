//
//  TabBarViewController.swift
//  OntPass
//
//  Created by Ross Krasner on 12/8/18.
//  Copyright © 2018 Ryu. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.hidesBackButton = true
        navigationItem.hidesBackButton = true
    }

}
