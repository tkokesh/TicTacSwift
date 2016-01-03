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
    @IBOutlet weak private var statusLabel: UILabel!
    
    let board = Board()
    var onMove = 1
    var playerMove = 0
    var playing = false
    var timer: NSTimer?
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        self.boardView.setUpSquares()
        
        self.playXButton.layer.borderWidth = 1.0
        self.playXButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.playOButton.layer.borderWidth = 1.0
        self.playOButton.layer.borderColor = UIColor.lightGrayColor().CGColor
    }

    func squareTapped(recognizer: UITapGestureRecognizer)
    {
        if (!self.playing) || (playerMove != onMove)
        {
            return
        }
        
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
        
        let (result, solutionIndex) = self.board.lastMoveEndedGame(index)
        if result
        {
            self.statusLabel.text = "You won. Drat."
            self.playing = false
            self.showPlayButtons(true)
            self.boardView.boardOverlay.solutionIndex = SolutionType(rawValue: solutionIndex)!
            self.boardView.boardOverlay.hidden = false
            self.boardView.boardOverlay.setNeedsDisplay()
            return
        }
        
        if (self.board.numFree == 0)
        {
            self.statusLabel.text = "Draw."
            self.playing = false
            self.showPlayButtons(true)
            return
        }
        
        self.setComputerMoveTimer()
    }

    @IBAction func changedDifficulty(sender: AnyObject)
    {
        
    }

    @IBAction func playX(sender: AnyObject)
    {
        if self.playing
        {
            return
        }
        
        self.resetBoard()
        self.boardView.boardOverlay.hidden = true
        
        self.playing = true
        self.onMove = 1
        self.playerMove = 1

        self.showPlayButtons(false)
        self.statusLabel.text = "Your move"
    }

    @IBAction func playO(sender: AnyObject)
    {
        if self.playing
        {
            return
        }

        self.resetBoard()
        self.boardView.boardOverlay.hidden = true

        self.playing = true
        self.onMove = 1
        self.playerMove = 2
        
        self.showPlayButtons(false)
        self.statusLabel.text = "Thinking..."
        self.performSelectorInBackground("computerPlay", withObject: nil)
    }

    func resetBoard()
    {
        self.board.clearBoard()
        self.boardView.resetSquareViewValues()
        self.boardView.setNeedsDisplay()
    }
    
    func showPlayButtons(show: Bool)
    {
        self.playXButton.hidden = !show
        self.playOButton.hidden = !show
    }
    
    func setComputerMoveTimer()
    {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "computerPlay", userInfo: nil, repeats: false)
        self.statusLabel.text = "Thinking..."
    }
    
    func computerPlay()
    {
        if onMove == playerMove
        {
            return
        }
        
        self.timer?.invalidate()
        
        let (index, _) = self.board.bestMove(onMove, depth: 0)
        let squareView = self.boardView.squares[index] as! SquareView

        squareView.squareValue = onMove
        self.board.setSquare(index, value: onMove)
        onMove = 3 - onMove

        squareView.setNeedsDisplay()
        
        let (result, solutionIndex) = self.board.lastMoveEndedGame(index)
        if result
        {
            self.statusLabel.text = "I win!"
            self.playing = false
            self.showPlayButtons(true)
            self.boardView.boardOverlay.solutionIndex = SolutionType(rawValue: solutionIndex)!
            self.boardView.boardOverlay.hidden = false
            self.boardView.boardOverlay.setNeedsDisplay()
            return
        }
        
        if (self.board.numFree == 0)
        {
            self.statusLabel.text = "Draw."
            self.playing = false
            self.showPlayButtons(true)
            return
        }

        self.statusLabel.text = "Your move"
    }
}

