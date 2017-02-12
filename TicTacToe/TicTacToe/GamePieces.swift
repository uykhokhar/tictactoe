//
//  GamePieces.swift
//  TicTacToe
//
//  Created by MouseHouseApp on 2/11/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import UIKit


//Enum to define type of piece

enum pieceType : String {
    case X = "X"
    case O = "O"
}

// Attribution: https://www.natashatherobot.com/non-optional-uiimage-named-swift/
extension pieceType {
    var image : UIImage {
        return UIImage(named: self.rawValue)!
    }
}

extension UIImage {
    convenience init(asset: pieceType) {
        self.init(named: asset.rawValue)!
    }
}



class GamePieces: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let type : pieceType
    
    // Attribution: - https://www.ioscreator.com/tutorials/dragging-views-gestures-tutorial-ios8-swift
    init(pieceType: pieceType){
        super.init(image: UIImage(asset: pieceType))
        
        //set location of pieces based on type
        switch pieceType {
        case .O:
            self.center = CGPoint(x: 314, y: 557)
            self.frame = CGRect(x: 314, y: 557, width: 90.0, height: 90.0)
        case .X:
            self.center = CGPoint(x: 61, y: 557)
            self.frame = CGRect(x: 61, y: 557, width: 90.0, height: 90.0)
        }
        
        //gesture added
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        self.addGestureRecognizer(panGesture)
        self.isUserInteractionEnabled = true
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handlePan(_ recognizer:UIPanGestureRecognizer) {
        
        // Determine where the view is in relation to the superview
        let translation = recognizer.translation(in: self.superview)
        
        if let view = recognizer.view {
            // Set the view's center to the new position
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        
        // Reset the translation back to zero, so we are dealing
        // in offsets
        recognizer.setTranslation(CGPoint.zero, in: self.superview)
        
        
        
        if recognizer.state == UIGestureRecognizerState.ended {
            print("ended at: \(recognizer)")
        }
        
        
    }
    
    

    
    
    

}


