//
//  Constants.swift
//  OntPass
//
//  Created by Ross Krasner on 12/8/18.
//  Copyright © 2018 Ryu. All rights reserved.
//

import Foundation
import UIKit

let regularFont = "SourceSansPro-Regular"
let lightFont = "SourceSansPro-ExtraLight"
let boldFont = "SourceSansPro-Semibold"

let deviceIsiPhone5s = screenHeight < 569

let screenWidth = UIScreen.main.bounds.width < UIScreen.main.bounds.height ?
    UIScreen.main.bounds.width : UIScreen.main.bounds.height
let screenHeight = UIScreen.main.bounds.width < UIScreen.main.bounds.height ?
    UIScreen.main.bounds.height : UIScreen.main.bounds.width

func hexStringToUIColor (hex: String) -> UIColor {
    var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if cString.hasPrefix("#") {
        cString.remove(at: cString.startIndex)
    }
    
    if (cString.count) != 6 {
        return UIColor.gray
    }
    
    var rgbValue: UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

extension UIView {
    func makeCircular() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
        self.clipsToBounds = true
    }
}
