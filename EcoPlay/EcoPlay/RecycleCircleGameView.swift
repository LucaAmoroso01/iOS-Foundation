//
//  RecycleGameView.swift
//  EcoPlay
//
//  Created by Rocco Del Prete on 18/04/2024.
//

import SwiftUI
import SpriteKit
import NavigationTransitions

struct RecycleCircleGameView: View {
    @State private var shouldGoBack = false
    @State private var showSettings = false
    @Binding var isActiveSoundeEffects: Bool
    @Binding var isActiveMusic: Bool
    
    @StateObject private var scene: RecycleCircleScene = {
        let scene = SKScene(fileNamed: "RecycleCircleScene") as! RecycleCircleScene
        scene.scaleMode = .aspectFill
                
        return scene
    }()

    var body: some View {
        NavigationStack {
            ZStack {
                if showSettings {
                    Settings(isActive: $showSettings, isActiveSoundEffects: $isActiveSoundeEffects, isActiveMusic: $isActiveMusic)
                        .foregroundStyle(Color.darkGreen.opacity(0.6))
                        .zIndex(200.0)
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
                ToolbarItem(placement: .topBarLeading, content: {
                    Button(action: {
                        shouldGoBack.toggle()
                    }, label: {
                        Image("arrowshape.turn.up.backward.fill")
                            .foregroundStyle(Color.darkGreen)
                    })
                    .navigationDestination(isPresented: $shouldGoBack, destination: {
                        LandsView()
                    })
                    .navigationDestination(isPresented: $scene.isGameEnded, destination: {
                        LandsView()
                    })
                })
            }
        }
        .navigationTransition(.slide)
    }
}

#Preview {
    RecycleCircleGameView(isActiveSoundeEffects: .constant(true), isActiveMusic: .constant(true))
}
