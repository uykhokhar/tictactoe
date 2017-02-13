//
//  SoundManager.swift
//  TicTacToe
//
//  Created by MouseHouseApp on 2/12/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import Foundation
import AudioToolbox

enum Sound : String {
    case buzzer = "Zip Line Bass 01"
    case beginDrag = "Breathless Harp"
    case win = "Neon Fireworks Beat 01"
}


class SoundManager {
    
    static let shared = SoundManager()
    
    private init(){}
    
    func play(effect: Sound){
        
        let soundURL = Bundle.main.url(forResource: effect.rawValue, withExtension: "caf")!
        
        var soundId: SystemSoundID = 0
        
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundId)
        
        AudioServicesAddSystemSoundCompletion(soundId, nil, nil, { (soundId, clientData) -> Void in
            AudioServicesDisposeSystemSoundID(soundId)
        }, nil)
        
        AudioServicesPlaySystemSound(soundId)
        
    }
    
}
