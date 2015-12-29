//
//  BoardView.swift
//  TicTacSwift
//
//  Created by Tim Kokesh on 12/23/15.
//  Copyright © 2015 Aqueous Software. All rights reserved.
//

import UIKit


class BoardView: UIView {
    
    var squares: NSMutableArray = NSMutableArray()
    var boardOverlay: BoardOverlayView
    @IBOutlet weak private var viewController: ViewController!
    
    required init?(coder aDecoder: NSCoder)
    {
        self.boardOverlay = BoardOverlayView(frame: CGRectZero)
        
        super.init(coder: aDecoder)
    }
    
    func setUpSquares()
    {
        let size = self.frame.size.width
        let lineWidth: CGFloat = 10
        let squareSize = (size - 2 * lineWidth) / 3
        
        for squareNum in 0..<9
        {
            let xcoord = squareNum % 3
            let ycoord = squareNum / 3
            let originx: CGFloat = (squareSize + lineWidth) * CGFloat(xcoord)
            let originy: CGFloat = (squareSize + lineWidth) * CGFloat(ycoord)
            let r = CGRectMake(originx, originy, squareSize, squareSize)
            
            let squareView = SquareView(frame: r)
            squareView.backgroundColor = UIColor.whiteColor()
            squareView.tag = squareNum + 1;
            squareView.addGestureRecognizer(UITapGestureRecognizer(target: self.viewController, action:"squareTapped:"))
            self.addSubview(squareView)
            
            self.squares.addObject(squareView)
        }
        
        self.boardOverlay = BoardOverlayView(frame: self.bounds)
        self.boardOverlay.hidden = true
        self.boardOverlay.backgroundColor = UIColor.clearColor()
        self.addSubview(self.boardOverlay)
    }
    
    func resetSquareViewValues()
    {
        for squareView in self.squares
        {
            (squareView as! SquareView).squareValue = 0
        }
    }
    
    override func setNeedsDisplay()
    {
        super.setNeedsDisplay()
        
        for squareView in self.squares
        {
            (squareView as! SquareView).setNeedsDisplay()
        }
    }
}
