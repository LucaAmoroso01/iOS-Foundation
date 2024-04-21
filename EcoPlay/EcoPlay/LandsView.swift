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
                TabView(selection: $currentView) {
                    ForEach(views, id: \.self) { view in
                        ZStack {
                            if view == "firstLandView" {
                                FirstLandView(isActiveSoundEffects: $isActiveSoundEffects, isActiveMusic: $isActiveMusic).tag("firstLandView")
                            } else {
                                SecondLandView(isActiveSoundEffects: $isActiveSoundEffects).tag("secondLandView")
                            }
                        }
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .never))
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
            ToolbarItem (placement: .principal, content: {
                Text(currentView == "firstLandView" ? "learn".uppercased() : "play".uppercased())
                    .font(Font.custom("Play-bold", size: 22))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 35)
                    .padding(.vertical, 5)
                    .foregroundStyle(.white)
                    .kerning(2)
                    .shadow(color: .black.opacity(25/100), radius: 2, x: 0, y: 4)
                    .blur(radius: 0.4)
                    .background(Color(red: 103/255, green: 235/255, blue: 0/255))
                    .clipShape(RoundedRectangle(cornerRadius: 33.0))
                    .overlay {
                        RoundedRectangle(cornerRadius: 33.0)
                            .stroke(.white, lineWidth: 3)
                    }
                    .opacity(showSettings ? 0.2 : 1.0)
            })
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
