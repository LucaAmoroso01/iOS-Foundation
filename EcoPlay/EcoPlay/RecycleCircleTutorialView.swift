//
//  RecycleGameView.swift
//  EcoPlay
//
//  Created by Rocco Del Prete on 18/04/2024.
//

import SwiftUI
import SpriteKit
import NavigationTransitions

struct RecycleCircleTutorialView: View {
    @State private var shouldGoBack = false
    
    @StateObject private var scene: RecycleCircleScene = {
        let scene = SKScene(fileNamed: "RecycleCircleScene") as! RecycleCircleScene
        scene.scaleMode = .aspectFill
        
        return scene
    }()
    
    var body: some View {
        NavigationStack {
            ZStack {
                SpriteView(scene: scene)
                    .ignoresSafeArea(.all)
                    .navigationBarBackButtonHidden(true)
            }
            .toolbar {
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
    RecycleCircleTutorialView()
}
