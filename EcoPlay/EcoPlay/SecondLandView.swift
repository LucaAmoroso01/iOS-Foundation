//
//  LandView.swift
//  EcoPlay
//
//  Future features
//
//  Created by Rocco Del Prete on 11/04/2024.
//

import SwiftUI
import NavigationTransitions

struct SecondLandView: View {
    enum WasteTypes: String {
        case organic = "organic"
        case mixed = "mixed"
        case plastic = "plastic"
        case paper = "paper"
    }
    
    @Binding var isActiveSoundEffects: Bool
    
    var body: some View {
        ZStack {
            Color.backgroundGreen.ignoresSafeArea()
            VStack {
                Spacer()
                HStack(alignment: .center, spacing: 1) {
                    VStack(alignment: .center) {
                        Spacer()
                        VStack(alignment: .center) {
                            Text("eco-sorter".uppercased())
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .font(.system(size: 20, design: .rounded))
                                .fontWeight(.bold)
                                .shadow(color: .black.opacity(25/100), radius: 2, x: 0, y: 4).blur(radius: 0.4)
                                .padding(.top, 5)
                            HStack(spacing: 20) {
                                ZStack {
                                    Text(WasteTypes.organic.rawValue.uppercased())
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 5)
                                        .font(.system(size: 16, weight: .heavy))
                                        .foregroundStyle(.white)
                                        .background(Color.darkGreen)
                                        .clipShape(.rect(topLeadingRadius: 28, topTrailingRadius: 28))
                                    Image("banana-peel")
                                        .resizable()
                                        .scaleEffect(CGSize(width: 0.9, height: 0.8))
                                        .padding()
                                        .frame(width: 116.5, height: 72)
                                        .background(Color.backgroundImageGray)
                                        .clipShape(.rect(bottomLeadingRadius: 28, bottomTrailingRadius: 28))
                                        .offset(CGSize(width: 0.0, height: 50.7))
                                        .overlay(content: {
                                            UnevenRoundedRectangle(bottomLeadingRadius: 28, bottomTrailingRadius: 28)
                                                .stroke(Color.darkGreen, lineWidth: 1)
                                                .offset(CGSize(width: -0.1, height: 50))
                                                .frame(width: 115.1, height: 72.2)
                                        })
                                }
                                ZStack {
                                    Text(WasteTypes.paper.rawValue.uppercased())
                                        .padding(.horizontal, 31)
                                        .padding(.vertical, 5)
                                        .font(.system(size: 16, weight: .heavy))
                                        .foregroundStyle(.white)
                                        .background(Color.darkGreen)
                                        .clipShape(.rect(topLeadingRadius: 28, topTrailingRadius: 28))
                                    Image("wastepaper")
                                        .resizable()
                                        .scaleEffect(CGSize(width: 0.7, height: 1.4))
                                        .padding(20)
                                        .frame(width: 116.5, height: 72)
                                        .background(Color.backgroundImageGray)
                                        .clipShape(.rect(bottomLeadingRadius: 28, bottomTrailingRadius: 28))
                                        .offset(CGSize(width: 0.0, height: 50.7))
                                        .overlay(content: {
                                            UnevenRoundedRectangle(bottomLeadingRadius: 28, bottomTrailingRadius: 28)
                                                .stroke(Color.darkGreen, lineWidth: 1)
                                                .offset(CGSize(width: -0.03, height: 50))
                                                .frame(width: 115, height: 72.5)
                                        })
                                }
                            }
                            .padding(.top, -10)
                            HStack(spacing: 20) {
                                ZStack {
                                    Text(WasteTypes.plastic.rawValue.uppercased())
                                        .padding(.horizontal, 23)
                                        .padding(.vertical, 5)
                                        .font(.system(size: 16, weight: .heavy))
                                        .foregroundStyle(.white)
                                        .background(Color.darkGreen)
                                        .clipShape(.rect(topLeadingRadius: 28, topTrailingRadius: 28))
                                    Image("plastic-bottle")
                                        .resizable()
                                        .scaleEffect(CGSize(width: 0.9, height: 0.9))
                                        .padding()
                                        .frame(width: 116.5, height: 72)
                                        .background(Color.backgroundImageGray)
                                        .clipShape(.rect(bottomLeadingRadius: 28, bottomTrailingRadius: 28))
                                        .offset(CGSize(width: 0.0, height: 50.7))
                                        .overlay(content: {
                                            UnevenRoundedRectangle(bottomLeadingRadius: 28, bottomTrailingRadius: 28)
                                                .stroke(Color.darkGreen, lineWidth: 1)
                                                .offset(CGSize(width: 0.1, height: 50))
                                                .frame(width: 115.75, height: 72)
                                        })
                                }
                                ZStack {
                                    Text(WasteTypes.mixed.rawValue.uppercased())
                                        .padding(.horizontal, 31)
                                        .padding(.vertical, 5)
                                        .font(.system(size: 16, weight: .heavy))
                                        .foregroundStyle(.white)
                                        .background(Color.darkGreen)
                                        .clipShape(.rect(topLeadingRadius: 28, topTrailingRadius: 28))
                                    Image("dirty-cardboard")
                                        .resizable()
                                        .scaleEffect(CGSize(width: 0.8, height: 0.9))
                                        .padding(15)
                                        .frame(width: 116.5, height: 72)
                                        .background(Color.backgroundImageGray)
                                        .clipShape(.rect(bottomLeadingRadius: 28, bottomTrailingRadius: 28))
                                        .offset(CGSize(width: 0.0, height: 50.7))
                                        .overlay(content: {
                                            UnevenRoundedRectangle(bottomLeadingRadius: 28, bottomTrailingRadius: 28)
                                                .stroke(Color.darkGreen, lineWidth: 1)
                                                .offset(CGSize(width: 0.13, height: 50))
                                                .frame(width: 114.3, height: 72.5)
                                        })
                                }
                            }
                            .padding(.top, 35)
                            Spacer()
                        }
                    }
                    .frame(width: 286, height: 324)
                    .background(Color.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 21.0))
                    .shadow(color: Color.darkGreen, radius: 0, x: 0, y: 8)
                }
                CustomButton(isActiveClick: $isActiveSoundEffects, navigate: .constant(false), buttonText: "Start")
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
