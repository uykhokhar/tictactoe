//
//  ViewController.swift
//  TicTacToe
//
//  Created by MouseHouseApp on 2/11/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import UIKit


struct ViewText {
    
    static let help = (tag: 301, button: "Got it!", text: "How to play. Players take turns: X's go first, O's go second. Player drags a shape into the grid. If any play gets three of their shapes into a row, column or diagonal, that player wins.")
    static let win = (tag: 302, button: "New Game", text: "Congratulations!")
    static let stalemate = (tag: 303, button: "OK", text: "The game is a stalemate")
}



class ViewController: UIViewController {


    var game = Game()
    var winner : pieceType?
    var line = CAShapeLayer()

    
    // MARK: -IBoutlets
    @IBOutlet weak var animatedView: UIView!
    @IBOutlet weak var aniViewButton: UIButton!
    @IBOutlet weak var aniTextView: UITextView!

    
    // MARK: -TileViews
    @IBOutlet weak var tile00: UIView!
    @IBOutlet weak var tile01: UIView!
    @IBOutlet weak var tile02: UIView!
    @IBOutlet weak var tile12: UIView!
    @IBOutlet weak var tile11: UIView!
    @IBOutlet weak var tile10: UIView!
    @IBOutlet weak var tile22: UIView!
    @IBOutlet weak var tile21: UIView!
    @IBOutlet weak var tile20: UIView!
    
    var tiles : [[UIView]] = [[]]
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        
        // initialize game and pieces
        self.view.addSubview(game.currentPiece)
        self.view.addSubview(game.otherPiece)
        
        addGesture(piece: game.currentPiece)
        addGesture(piece: game.otherPiece)
        
        game.currentPiece.enable()
        game.currentPiece.scaleAnimation()
        game.otherPiece.diable(alpha: 0.5)
        self.tiles = [[tile00, tile01, tile02], [tile10, tile11, tile12], [tile20, tile21, tile22]]
        
        // initialize helperview
        animatedView.center.x = self.view.bounds.width/2
        animatedView.center.y -= self.view.bounds.height

        
        super.viewDidLoad()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Game logic
    
    //Add gesture to piece 
    func addGesture(piece: GamePieces) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        piece.addGestureRecognizer(panGesture)
        
    }
    
    
    //Check if center of view is in other view
    //return tag of view it itersects with
    func checkIntersection(piece: GamePieces) -> (row: Int, column: Int)? {
        var tile : (row: Int, column: Int)? = nil
        
        let center = game.currentPiece.center
        
        for i in 0...2 {
            for j in 0...2 {
                let viewToCheck = tiles[i][j]
                if viewToCheck.frame.contains(center){
                    tile = (row: i, column: j)
                }
            }
        }
        return tile
    }
    
    
    
    //check to make sure tile is not filled. check against the gameBoard
    func checkValidPlacement(tile: (row: Int, column: Int )) -> Bool {
        return !game.tileFilled(row: tile.row, column: tile.column)
    }
    
    
    //if valid placement snap into place, set the board piece, check winner,
    func snapIntoPlace(piece: GamePieces, tile: (row: Int, column: Int )){
        
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseInOut,
                       animations: {
                        piece.center.y = self.tiles[tile.row][tile.column].center.y
                        piece.center.x = self.tiles[tile.row][tile.column].center.x
        }, completion: nil
        )
        
    }
    
    
    //if invalid placement play sound and animate back to place 
    func snapToOrgin(piece: GamePieces){
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseInOut,
                       animations: {
                        piece.center.y = piece.origin().y
                        piece.center.x = piece.origin().x
        }, completion: nil
        )

    }
    
    func nextTurn(){
        let newPiece = game.nextTurn()
        addGesture(piece: newPiece)
        self.view.addSubview(newPiece)
    }
    
    
    func newBoard() {
        
        for piece in game.allPieces {
            UIView.animate(withDuration: 0.8, delay: 0.2, options: .curveEaseInOut,
                           animations: {
                            piece.center.x -= self.view.bounds.width
            }, completion: nil
            )
        }
        game.newGame()
        
        self.view.addSubview(game.currentPiece)
        self.view.addSubview(game.otherPiece)
        
        addGesture(piece: game.currentPiece)
        addGesture(piece: game.otherPiece)
        
        game.currentPiece.enable()
        game.currentPiece.scaleAnimation()
        game.otherPiece.diable(alpha: 0.5)
        
        
    }
    
    // ATTRIBUTION: http://stackoverflow.com/questions/40556112/how-to-draw-a-line-in-swift-3
    func drawLine(acrossTiles: (startRow: Int, startCol: Int, endRow: Int, endCol: Int )) {
        
        let start = tiles[acrossTiles.startRow][acrossTiles.startCol].center
        let end = tiles[acrossTiles.endRow][acrossTiles.endCol].center
        
        line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = UIColor.green.cgColor
        line.lineWidth = 12
        line.lineJoin = kCALineJoinRound
        self.view.layer.addSublayer(line)
    }
    
    
    
    // MARK: helper view
    func genericPresentView(title: String, text: String){
        
        if self.animatedView.center.y > self.view.bounds.height {
            animatedView.center.y -= 2 * self.view.bounds.height
        }
        
        self.view.bringSubview(toFront: animatedView)
        
        aniTextView.text = text
        aniViewButton.setTitle(title, for: .normal)
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseInOut,
                       animations: {
                        self.animatedView.center.y += self.view.bounds.height
        }, completion: nil
        )
    }
    
    // ATTRIBUTION: delay presentation of new board until animation removed: http://stackoverflow.com/questions/28821722/delaying-function-in-swift
    func genericDismissView(){
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveLinear,
                       animations: {
                        self.animatedView.center.y += self.view.bounds.height
        }, completion: nil
        )
        
        
        //post dismissal logic delayed
        unowned let unownedSelf = self
        
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            unownedSelf.dismissViewSwitch()
        })
        
        
        

    }
    
    func dismissViewSwitch(){
        
        switch aniViewButton.currentTitle! {
        case ViewText.help.button:
            game.currentPiece.enable()
        case ViewText.win.button:
            newBoard()
            line.removeFromSuperlayer()
        case ViewText.stalemate.button:
            newBoard()
        default:
            print("default case ", #function)
        }

    }

    
    
    
    // How to play view controller
    @IBAction func presentView(_ sender: Any) {

        genericPresentView(title: ViewText.help.button, text: ViewText.help.text)
        print(ViewText.help.button)
    }
    
    
    
    @IBAction func dismissView(_ sender: Any) {
        
        genericDismissView()

    }
    
    
    
    // winning view controller 
    func presentWinView(winningPiece: pieceType){
        
        let text = ViewText.win.text + " " + winningPiece.rawValue + " won!"
        genericPresentView(title: ViewText.win.button, text: text)
    }
    
    
    
    // stalemate view controller 
    func presentStaleMate(){
        genericPresentView(title: ViewText.stalemate.button, text: ViewText.stalemate.text)
    }
    
    
    
    // MARK: Gesture Handling and game logic implementation
    func handlePan(_ recognizer:UIPanGestureRecognizer) {
        
        // Determine where the view is in relation to the superview
        let translation = recognizer.translation(in: self.view)
        
        if let view = recognizer.view {
            // Set the view's center to the new position
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        
        // Reset the translation back to zero, so we are dealing
        // in offsets
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        
        
        if recognizer.state == UIGestureRecognizerState.began {
            print("began dragging")
            
            SoundManager.shared.play(effect: .beginDrag)
        }
        
        
        
        
         if recognizer.state == UIGestureRecognizerState.ended {
            print("ended at: \(recognizer)")
            if let tile = checkIntersection(piece: game.currentPiece){
                if checkValidPlacement(tile: tile){
                    //if valid placement: snap into place, play sound, update game board, check winner, else check if draw
                    snapIntoPlace(piece: game.currentPiece, tile: tile)
                    SoundManager.shared.play(effect: .sucess)
                    game.setTile(row: tile.row, column: tile.column, piece: game.currentPiece.type)
                    
                    //if winner present winner, else if game over then make new game, else, make new turn
                    winner = game.checkWinner()
                    if let winner = winner {
                        print("winner is \(winner.rawValue)")
                        game.allPieces.append(game.otherPiece)
                        drawLine(acrossTiles: game.winningTiles!)
                        SoundManager.shared.play(effect: .win)
                        presentWinView(winningPiece: winner)
                    } else if game.gameOver { //new board
                        print("Game Over!")
                        presentStaleMate()
                    } else {
                        nextTurn()
                    }

                } else {//if in valid placement: snap to orgin, play sound

                    snapToOrgin(piece: game.currentPiece)
                    SoundManager.shared.play(effect: .buzzer)
                }
            } else {//if no intersection, snaptoOrgin
                snapToOrgin(piece: game.currentPiece)
                SoundManager.shared.play(effect: .buzzer)
            }
        }
    }

    
}

