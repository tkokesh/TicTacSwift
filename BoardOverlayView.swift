//
//  BoardOverlayView.swift
//  TicTacSwift
//
//  Created by Tim Kokesh on 12/29/15.
//  Copyright © 2015 Aqueous Software. All rights reserved.
//

import UIKit

class BoardOverlayView: UIView {
    
    enum SolutionType: Int
    {
        case solution_row1 = 0,
        solution_row2,
        solution_row3,
        solution_col1,
        solution_col2,
        solution_col3,
        solution_backslash,
        solution_slash
    }
    
    var solutionIndex: SolutionType = .solution_row1
    var squareSize: CGFloat = 0
    
    override func drawRect(rect: CGRect)
    {
        let c = UIGraphicsGetCurrentContext()
        let r = self.bounds
        var fromPt, toPt: CGPoint
        
        switch (solutionIndex)
        {
            case .solution_row1:
                fromPt = CGPointMake(0, squareSize / 2)
                toPt = CGPointMake(r.size.width, squareSize / 2)
                break

            case .solution_row2:
                fromPt = CGPointMake(0, r.size.height / 2)
                toPt = CGPointMake(r.size.width, r.size.height / 2)
                break
                
            case .solution_row3:
                fromPt = CGPointMake(0, r.size.height - squareSize / 2)
                toPt = CGPointMake(r.size.width, r.size.height - squareSize / 2)
                break
                
            case .solution_col1:
                fromPt = CGPointMake(squareSize / 2, 0)
                toPt = CGPointMake(squareSize / 2, r.size.height)
                break
                
            case .solution_col2:
                fromPt = CGPointMake(r.size.width / 2, 0)
                toPt = CGPointMake(r.size.width / 2, r.size.height)
                break
                
            case .solution_col3:
                fromPt = CGPointMake(r.size.width - squareSize / 2, 0)
                toPt = CGPointMake(r.size.width - squareSize, r.size.height)
                break
                
            case .solution_backslash:
                fromPt = CGPointMake(0, 0)
                toPt = CGPointMake(r.size.width, r.size.height)
                break
                
            case .solution_slash:
                fromPt = CGPointMake(0, r.size.height)
                toPt = CGPointMake(r.size.width, 0)
                break
        }
    
        CGContextSetLineWidth(c, 5.0)
        CGContextSetStrokeColorWithColor(c, UIColor(white: 0, alpha: 0.25).CGColor)
        
        CGContextMoveToPoint(c, fromPt.x, fromPt.y)
        CGContextAddLineToPoint(c, toPt.x, toPt.y)
        CGContextStrokePath(c)
    }
}
