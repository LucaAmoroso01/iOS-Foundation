//
//  LandsView.swift
//  EcoPlay
//
//  Created by Rocco Del Prete on 16/04/2024.
//

import SwiftUI
import AVFoundation

struct LandsView: View {
    let views: [String] = ["firstLandView", "secondLandView"]
    @State private var showSettings = false
    @State private var currentView = "firstLandView"
    @State private var isActiveSoundEffects = true
    @State private var isActiveMusic = true
    
    private let backgroundMusic = BackgroundMusic.getBackgroundMusic()
    
    var body: some View {
        ZStack {
            Color.backgroundGreen.ignoresSafeArea()
            if showSettings {
                Settings(isActive: $showSettings, isActiveSoundEffects: $isActiveSoundEffects, isActiveMusic: $isActiveMusic)
                    .background(Color.darkGreen.opacity(0.6))
                    .zIndex(200.0)
            }
            VStack {
                FirstLandView(isActiveSoundEffects: $isActiveSoundEffects, isActiveMusic: $isActiveMusic)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation(.easeInOut, {
                        showSettings.toggle()
                    })
                } label: {
                    Image(systemName: "gearshape.fill")
                        .foregroundStyle(Color.darkGreen.opacity(showSettings ? 0.35 : 1.0))
                }
                .disabled(showSettings)
            }
        }
        .onAppear() {
            backgroundMusic.numberOfLoops = -1
            backgroundMusic.play()
        }
    }
}

#Preview {
    LandsView()
}
