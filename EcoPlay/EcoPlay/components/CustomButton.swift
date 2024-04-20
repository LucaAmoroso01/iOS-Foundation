//
//  ButtonView.swift
//  EcoPlay
//
//  Created by Rocco Del Prete on 16/04/2024.
//

import SwiftUI

struct CustomButton: View {
    @Binding var isActiveClick: Bool
    @Binding var navigateToGame: Bool
    private let clickSound = SoundEffects.getSoundFromKey(key: "click")
    var buttonText: String
    
    var body: some View {
        Button(action: {
            navigateToGame.toggle()
            if let click = clickSound {
                if isActiveClick {
                    click.play()
                }
            }
        }, label: {
            Text(buttonText)
                .font(Font.custom("Play-Bold", size: 24))
                .kerning(2)
                .padding(.horizontal, 40)
                .padding(.vertical, 15)
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(25/100), radius: 2, x: 0, y: 4)
                .blur(radius: 0.4)
                .background(Color(red: 103/255, green: 235/255, blue: 0/255))
                .clipShape(RoundedRectangle(cornerRadius: 33.0))
                .shadow(color: Color(red: 0, green: 129/255, blue: 31/255), radius: 0, x: 0, y: 10)
                .overlay(RoundedRectangle(cornerRadius: 33.0).stroke(.white, lineWidth: 3))
        })
    }
}

#Preview {
    CustomButton(isActiveClick: .constant(true), navigateToGame: .constant(false), buttonText: "test")
}
