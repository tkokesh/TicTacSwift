//
//  ViewController.swift
//  TicTacSwift
//
//  Created by Tim Kokesh on 12/23/15.
//  Copyright © 2015 Aqueous Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak private var boardView: BoardView!
    @IBOutlet weak private var playXButton: UIButton!
    @IBOutlet weak private var playOButton: UIButton!
    @IBOutlet weak private var resetPuzzleButton: UIButton!
    
    let board = Board()
    var onMove = 1
    var playing = false
    var timer: NSTimer?
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        self.boardView.setUpSquares()
    }

    func squareTapped(recognizer: UITapGestureRecognizer)
    {
        let view = recognizer.view as! SquareView
        let index = view.tag - 1
        
        if self.board.squareNotZero(index)
        {
            return
        }
        
        view.squareValue = onMove
        self.board.setSquare(index, value: onMove)
        onMove = 3 - onMove
        
        view.setNeedsDisplay()
        
        if (self.board.lastMoveEndedGame(index) || (self.board.numFree == 0))
        {
            print("Game over!")
            self.playing = false
            return
        }
        
        self.setComputerMoveTimer()
    }
    
    @IBAction func playX(sender: AnyObject)
    {
        
    }

    @IBAction func playO(sender: AnyObject)
    {
    }

    @IBAction func resetPuzzle(sender: AnyObject)
    {
        self.board.clearBoard()
        self.boardView.resetSquareViewValues()
        self.boardView.setNeedsDisplay()
        
        self.onMove = 1
    }
    
    func setComputerMoveTimer()
    {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "computerPlay", userInfo: nil, repeats: false)
    }
    
    func computerPlay()
    {
        self.timer?.invalidate()
        
        let (index, _) = self.board.bestMove(onMove, depth: 0)
        let squareView = self.boardView.squares[index] as! SquareView
        
        squareView.squareValue = onMove
        self.board.setSquare(index, value: onMove)
        onMove = 3 - onMove

        squareView.setNeedsDisplay()
        
        if (self.board.lastMoveEndedGame(index) || (self.board.numFree == 0))
        {
            print("Game over!")
            self.playing = false
            return
        }
    }
}

