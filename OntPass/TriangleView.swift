//
//  TriangleView.swift
//
//
//  Created by Ross Krasner on 11/27/18.
//

import Foundation
import UIKit

class TriangleView: UIView {
    var color: UIColor = .white {
        didSet {
            self.setNeedsLayout()
        }
    }
    convenience init(frame: CGRect, color: UIColor) {
        self.init(frame: frame)
        self.color = color
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.minY))
        context.closePath()
        context.setFillColor(self.color.cgColor)
        context.fillPath()
    }
}
