//
//  LandView.swift
//  EcoPlay
//
//  Created by Rocco Del Prete on 11/04/2024.
//

import SwiftUI
import NavigationTransitions

struct FirstLandView: View {
    @State private var showSettings = false
    @Binding var isActiveSoundEffects: Bool
    @Binding var isActiveMusic: Bool
    @State private var navigateToTutorial = false
    @State private var navigateToGame = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundGreen.ignoresSafeArea()
                VStack {
                    Spacer()
                    HStack(alignment: .center, spacing: 1) {
                        VStack(alignment: .center) {
                            Text("recycle\ncyrcle".uppercased())
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .font(.system(size: 20, design: .rounded))
                                .fontWeight(.bold)
                                .shadow(color: .black.opacity(25/100), radius: 2, x: 0, y: 4).blur(radius: 0.4)
                                .padding(.top, 20)
                            Spacer()
                            Image("plastic-bottle")
                                .resizable()
                                .scaledToFit()
                                .padding(60)
                                .background(
                                    Gradient(colors: [
                                        Color(red: 81/255, green: 139/255, blue: 84/255),
                                        Color.darkGreen
                                    ])
                                )
                                .clipShape(Circle())
                                .padding(25)
                            Spacer()
                        }
                        .frame(width: 286, height: 324)
                        .background(Color.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 21.0))
                        .shadow(color: Color.darkGreen, radius: 0, x: 0, y: 8)
                    }
                    VStack(spacing: 30){
                        CustomButton(isActiveClick: $isActiveSoundEffects, navigate: $navigateToTutorial, buttonText: "Tutorial")
                            .navigationDestination(
                                isPresented: $navigateToTutorial, destination: {
                                    RecycleCircleTutorialView()
                                })
                        CustomButton(isActiveClick: $isActiveSoundEffects, navigate: $navigateToGame, buttonText: "Game", horizontalPadding: 55)
                            .navigationDestination(
                                isPresented: $navigateToGame, destination: {
                                    RecycleCircleGameView()
                                })
                    }
                    .padding(.horizontal, 14)
                    .padding(.top, 40)
                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
            }
        }
        .navigationTransition(.fade(.in).animation(.easeIn(duration: 0.5)))
    }
}

#Preview {
    FirstLandView(isActiveSoundEffects: .constant(true), isActiveMusic: .constant(true))
}
