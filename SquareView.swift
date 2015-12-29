//
//  SquareView.swift
//  TicTacSwift
//
//  Created by Tim Kokesh on 12/23/15.
//  Copyright © 2015 Aqueous Software. All rights reserved.
//

import UIKit


let inset: CGFloat = 0.20
let lineWidth: CGFloat = 0.15


class SquareView: UIView {
    
    var squareValue: Int = 0

    override func drawRect(rect: CGRect)
    {
        let c = UIGraphicsGetCurrentContext()!
        let size = self.frame.size

        CGContextSetLineWidth(c, size.width * lineWidth)

        switch squareValue
        {
            case 1:
                CGContextSetStrokeColorWithColor(c, UIColor.blueColor().CGColor)
                CGContextMoveToPoint(c, size.width * inset, size.height * inset)
                CGContextAddLineToPoint(c, size.width * (1 - inset), size.height * (1 - inset))
                CGContextMoveToPoint(c, size.width * (1 - inset), size.height * inset)
                CGContextAddLineToPoint(c, size.width * inset, size.height * (1 - inset))
                break
                
            case 2:
                CGContextSetStrokeColorWithColor(c, UIColor.redColor().CGColor)
                CGContextAddEllipseInRect(c, CGRectInset(self.bounds, size.width * inset, size.height * inset))
                break
                
            default:
                break
        }
        
        CGContextStrokePath(c)
    }
}
