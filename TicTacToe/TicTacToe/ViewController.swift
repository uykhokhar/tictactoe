//
//  ViewController.swift
//  TicTacToe
//
//  Created by MouseHouseApp on 2/11/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var xPiece = GamePieces(pieceType: .X)
    var yPiece = GamePieces(pieceType: .O)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(xPiece)
        self.view.addSubview(yPiece)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

