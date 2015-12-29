//
//  BoardOverlayView.swift
//  TicTacSwift
//
//  Created by Tim Kokesh on 12/29/15.
//  Copyright © 2015 Aqueous Software. All rights reserved.
//

import UIKit

class BoardOverlayView: UIView {
    
    var solutionIndex = 0
    var squareSize: CGFloat = 0
    
    override func drawRect(rect: CGRect)
    {
        let c = UIGraphicsGetCurrentContext()
        let r = self.bounds
        var fromPt, toPt: CGPoint
        
        switch (solutionIndex)
        {
            case 0:
                fromPt = CGPointMake(0, squareSize / 2)
                toPt = CGPointMake(r.size.width, squareSize / 2)
                break

            case 1:
                fromPt = CGPointMake(0, r.size.height / 2)
                toPt = CGPointMake(r.size.width, r.size.height / 2)
                break
                
            case 2:
                fromPt = CGPointMake(0, r.size.height - squareSize / 2)
                toPt = CGPointMake(r.size.width, r.size.height - squareSize / 2)
                break
                
            case 3:
                fromPt = CGPointMake(squareSize / 2, 0)
                toPt = CGPointMake(squareSize / 2, r.size.height)
                break
                
            case 4:
                fromPt = CGPointMake(r.size.width / 2, 0)
                toPt = CGPointMake(r.size.width / 2, r.size.height)
                break
                
            case 5:
                fromPt = CGPointMake(r.size.width - squareSize / 2, 0)
                toPt = CGPointMake(r.size.width - squareSize, r.size.height)
                break
                
            case 6:
                fromPt = CGPointMake(0, 0)
                toPt = CGPointMake(r.size.width, r.size.height)
                break
                
            case 7:
                fromPt = CGPointMake(0, r.size.height)
                toPt = CGPointMake(r.size.width, 0)
                break

            default:
                fromPt = CGPointZero
                toPt = CGPointZero
                break
        }
    
        CGContextSetLineWidth(c, 5.0)
        CGContextSetStrokeColorWithColor(c, UIColor(white: 0, alpha: 0.25).CGColor)
        
        CGContextMoveToPoint(c, fromPt.x, fromPt.y)
        CGContextAddLineToPoint(c, toPt.x, toPt.y)
        CGContextStrokePath(c)
    }

}
