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
    
    var type : pieceType
    var state : Bool = false
    let xOrigin = CGPoint(x: 61, y: 557)
    let oOrigin = CGPoint(x: 314, y: 557)
    
    
    // Attribution: - https://www.ioscreator.com/tutorials/dragging-views-gestures-tutorial-ios8-swift
    init(type: pieceType){
        self.type = type
        super.init(image: UIImage(asset: type))
        
        //set location of pieces based on type
        switch type {
        case .O:
            self.center = oOrigin
            self.frame = CGRect(x: 269, y: 512, width: 90.0, height: 90.0)
        case .X:
            self.center = xOrigin
            self.frame = CGRect(x: 16 , y: 512, width: 90.0, height: 90.0)
        }
        
        self.backgroundColor = UIColor.clear
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    // Mark: -Game Play functions
    func diable(alpha: CGFloat){
        self.isUserInteractionEnabled = false
        self.alpha = alpha
    }

    func enable(){
        self.isUserInteractionEnabled = true
        self.alpha = 1
    }
    
    
    func scaleAnimation(){
        UIView.animate(withDuration: 0.3, delay: 0.1,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 2, y: 2)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.6) {
                            self.transform = CGAffineTransform.identity
                        }
        })
    }
    
    func origin() -> CGPoint {
        let orgin : CGPoint
        
        switch self.type {
        case .O:
            orgin = oOrigin
        case .X:
            orgin = xOrigin
        }
        return orgin
        
    }

}


