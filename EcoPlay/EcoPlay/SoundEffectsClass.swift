//
//  SoundsEffectsClass.swift
//  EcoPlay
//
//  Created by Rocco Del Prete on 16/04/2024.
//

import AVFoundation

class SoundEffectsClass {
    private static let click = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "click", withExtension: "mp3")!)
    
    private static let sounds = ["click": click]
    
    private init() {}
    
    static func getSoundEffects() -> [AVAudioPlayer] {
        Array(sounds.values)
    }
    
    static func getSoundFromKey(key: String) -> AVAudioPlayer? {
        sounds[key]
    }
}
