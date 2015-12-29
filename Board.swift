//
//  Board.swift
//  TicTacSwift
//
//  Created by Tim Kokesh on 12/23/15.
//  Copyright © 2015 Aqueous Software. All rights reserved.
//

import UIKit


let solutions = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
                 [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]


class Board: NSObject, NSCopying {

    var squares = NSMutableArray(capacity: 9)
    var numFree: Int
    
    override init()
    {
        self.numFree = 0
        
        super.init()

        self.clearBoard()
    }

    func clearBoard()
    {
        squares.removeAllObjects()
        
        for _ in 0..<9
        {
            squares.addObject(0)
        }
        
        self.numFree = 9
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject
    {
        let copyBoard = Board()
        copyBoard.squares = self.squares.mutableCopy() as! NSMutableArray
        copyBoard.numFree = self.numFree
        
        return copyBoard
    }
    
    func squareNotZero(index: Int) -> Bool
    {
        return ((squares[index] as! Int) != 0)
    }
    
    func setSquare(index: Int, value: Int)
    {
        squares[index] = value
        self.numFree--
    }
    
    func lastMoveEndedGame(index:Int) -> (Bool, Int)
    {
        for solutionIndex in 0..<8
        {
            let solution = solutions[solutionIndex]
            if (solution.indexOf(index) != nil)
            {
                var product = 1
                for solIndex in solution
                {
                    product *= self.squares[solIndex] as! Int
                }
                
                if (product == 1) || (product == 8)
                {
                    return (true, solutionIndex)
                }
            }
        }
        
        return (false, -1)
    }
    
    func bestMove(player: Int, depth: Int) -> (Int, Int) // best move and eval
    {
        let win = 100
        let bestMoves = NSMutableArray();
        var maximum = -win * 2;
        var eval: Int;
        
        if self.numFree == 0
        {
            return (-1, 0) // no moves left
        }
        
        for index in 0..<9
        {
            if self.squares[index] as! Int == 0
            {
                let thinkBoard = self.copy() as! Board
                thinkBoard.setSquare(index, value: player)
                let (result, _) = thinkBoard.lastMoveEndedGame(index)
                if result
                {
                    return (index, win - depth)
                }
                
                (_, eval) = thinkBoard.bestMove(3 - player, depth: depth + 1)
                if (-eval > maximum)
                {
                    maximum = -eval;
                    bestMoves.removeAllObjects()
                    bestMoves.addObject(index)
                }
                else
                    if -eval == maximum
                    {
                        bestMoves.addObject(index)
                    }
            }
        }
        
        let bestMoveIndex: Int = random() % bestMoves.count
        return (bestMoves[bestMoveIndex] as! Int, maximum)
    }

}
