//
//  LandView.swift
//  EcoPlay
//
//  Created by Rocco Del Prete on 11/04/2024.
//

import SwiftUI
import NavigationTransitions

struct SecondLandView: View {
    @Binding var isActiveSoundEffects: Bool
    
    var body: some View {
        ZStack {
            Color.backgroundGreen.ignoresSafeArea()
            VStack {
                Spacer()
                HStack(alignment: .center, spacing: 1) {
                    VStack(alignment: .center) {
                        VStack(alignment: .center) {
                            Text("eco-sorter".uppercased())
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .font(.system(size: 20, design: .rounded))
                                .fontWeight(.bold)
                                .shadow(color: .black.opacity(25/100), radius: 2, x: 0, y: 4).blur(radius: 0.4)
                                .padding(.top, 20)
                            Spacer()
                            HStack(spacing: 20) {
                                ForEach(1..<4) { i in
                                    Text("?")
                                        .font(.system(size: 20, weight: .bold))
                                        .multilineTextAlignment(.center)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 30)
                                        .background(Color.darkGreen)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                }
                            }
                            HStack(spacing: 20) {
                                ForEach(1..<4) { i in
                                    Text("?")
                                        .font(.system(size: 20, weight: .bold))
                                        .multilineTextAlignment(.center)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 30)
                                        .background(Color.darkGreen)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                }
                            }
                            Spacer()
                        }
                        .frame(width: 286, height: 324)
                        .background(Color.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 21.0))
                        .shadow(color: Color.darkGreen, radius: 0, x: 0, y: 8)
                        Spacer()
                    }
                    .frame(width: 286, height: 324)
                    .background(Color.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 21.0))
                    .shadow(color: Color.darkGreen, radius: 0, x: 0, y: 8)
                }
                CustomButton(isActiveClick: $isActiveSoundEffects, buttonText: "Start")
                .padding(.top, 40)
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SecondLandView(isActiveSoundEffects: .constant(true))
}
