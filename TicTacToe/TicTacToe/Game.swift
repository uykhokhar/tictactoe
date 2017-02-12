//
//  Game.swift
//  TicTacToe
//
//  Created by MouseHouseApp on 2/11/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import Foundation

class Game {
    
    
    var currentPiece : GamePieces
    var xPiece : GamePieces
    var oPiece : GamePieces
    var boardPieces : [[pieceType?]] = []
    
    
    init() {
        
        xPiece = GamePieces(pieceType: .X)
        oPiece = GamePieces(pieceType: .O)
        
        currentPiece = xPiece
        
    }
    
    
    
    //next turn
    func nextTurn() {
        switch currentPiece.type {
        case .X:
            currentPiece = oPiece
        case .O:
            currentPiece = xPiece
        }
    }
    
    
    //check for winner return type of piece
    func checkWinner() -> pieceType? {
        
        return nil
    }
    
    
    //set piece
    func setTile(row: Int, column: Int, piece: pieceType){
        boardPieces[row][column] = piece
    }
    
    func getTile(row: Int, column: Int) -> pieceType?{
        return boardPieces[row][column]
    }
    
    
    
}
