//
//  BackgroundMusicClass.swift
//  EcoPlay
//
//  Created by Rocco Del Prete on 16/04/2024.
//

import AVFoundation

class BackgroundMusic {
    private static let backgroundMusic = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "background-music", withExtension: "mp3")!)
    
    private init() {}
    
    static func getBackgroundMusic() -> AVAudioPlayer {
        return backgroundMusic
    }
}
