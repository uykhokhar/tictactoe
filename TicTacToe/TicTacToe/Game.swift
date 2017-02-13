//
//  Game.swift
//  TicTacToe
//
//  Created by MouseHouseApp on 2/11/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import Foundation

class Game {
    
    
    //anytime new current piece is set, append to all pieces
    var currentPiece : GamePieces {
        willSet {
            allPieces.append(newValue)
        }
    }
    var otherPiece : GamePieces
    var allPieces : [GamePieces] = []
    
    var boardPieces : [[pieceType?]] = [[nil,nil,nil], [nil,nil,nil],[nil,nil,nil]]
    var countFilled : Int = 0
    var gameOver : Bool {
        return countFilled > 8
    }

    
    
    init() {
        
        
        currentPiece = GamePieces(type: .X)
        allPieces.append(currentPiece)
        otherPiece = GamePieces(type: .O)
        
    }
    
    // Mark: game play
    //next turn: create new piece for the type that just ended and make the currentPiece the unplayed piece
    func nextTurn() -> GamePieces {
        
        var newPiece : GamePieces
        
        //lock completed piece in place
        currentPiece.diable(alpha: 1)
        
        //make a new piece of the completed type
        //make other piece the current piece 
        //make the new piece the other piece so that it can be disabled
        switch currentPiece.type {
        case .X:
            newPiece = GamePieces(type: .X)
            currentPiece = otherPiece
            otherPiece = newPiece
        case .O:
            newPiece = GamePieces(type: .O)
            currentPiece = otherPiece
            otherPiece = newPiece
        }
        
        
        otherPiece.diable(alpha: 0.5)
        currentPiece.enable()
        currentPiece.scaleAnimation()
        return newPiece
    }
    
    
    func newGame() {
        boardPieces = [[nil,nil,nil], [nil,nil,nil],[nil,nil,nil]]
        countFilled = 0
        allPieces = []
        currentPiece = GamePieces(type: .X)
        
    }
    
    
    
    // Mark: -check winner
    func checkWinner() -> pieceType? {
        
        for i in 0...2 {
            if let returnPiece = checkRow(row: i){
                return returnPiece
            }
        }
        
        for j in 0...2 {
            if let returnPiece = checkColumn(col: j){
                return returnPiece
            }
        }
        if let returnPiece = checkDiagonal1() {
            return returnPiece
        }
        if let returnPiece = checkDiagonal2() {
            return returnPiece
        }
        
        return nil
    }
    
    func checkColumn(col : Int) -> pieceType? {
        let returnPiece : pieceType?
        
        if ((boardPieces[0][col] == boardPieces[1][col]) &&  (boardPieces[1][col] == boardPieces[2][col])) {
            returnPiece = boardPieces[0][col]
        } else {
            returnPiece = nil
        }
        
        return returnPiece
        
    }
    
    func checkRow(row : Int) -> pieceType? {
        let returnPiece : pieceType?
        
        //ensure nil doesn't equal nil
        if ((boardPieces[row][0] == boardPieces[row][1]) &&  (boardPieces[row][1] == boardPieces[row][2])) {
            returnPiece = boardPieces[row][0]
        } else {
            returnPiece = nil
        }
        
        return returnPiece
        
    }
    
    func checkDiagonal1() -> pieceType? {
        let returnPiece : pieceType?
        
        //ensure nil doesn't equal nil
        if ((boardPieces[0][0] == boardPieces[1][1]) &&  (boardPieces[1][1] == boardPieces[2][2])) {
            returnPiece = boardPieces[0][0]
        } else {
            returnPiece = nil
        }
        
        return returnPiece
        
    }


    func checkDiagonal2() -> pieceType? {
        let returnPiece : pieceType?
        
        //ensure nil doesn't equal nil
        if ((boardPieces[0][2] == boardPieces[1][1]) &&  (boardPieces[1][1] == boardPieces[2][0])) {
            returnPiece = boardPieces[1][1]
        } else {
            returnPiece = nil
        }
        
        return returnPiece
        
    }
    
    
    // Mark: - tile functions
    func setTile(row: Int, column: Int, piece: pieceType){
        boardPieces[row][column] = piece
        countFilled += 1
    }
    
    func getTile(row: Int, column: Int) -> pieceType?{
        return boardPieces[row][column]
    }
    
    func tileFilled(row: Int, column: Int) -> Bool {
        if getTile(row: row, column: column) != nil{
            return true
        }
        return false
    }
    
    
    
    
    
}
