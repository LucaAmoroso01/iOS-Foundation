//
//  ButtonView.swift
//  EcoPlay
//
//  Created by Rocco Del Prete on 16/04/2024.
//

import SwiftUI

struct CustomButton: View {
    @Binding var isActiveClick: Bool
    @Binding var navigate: Bool
    private let clickSound = SoundEffects.getSoundFromKey(key: "click")
    var buttonText: String
    var horizontalPadding: CGFloat = 40
    var verticalPadding: CGFloat = 15
    
    var body: some View {
        Button(action: {
            navigate.toggle()
            if let click = clickSound {
                if isActiveClick {
                    click.play()
                }
            }
        }, label: {
            Text(buttonText)
                .font(Font.custom("Play-Bold", size: 22))
                .kerning(2)
                .padding(.horizontal, horizontalPadding)
                .padding(.vertical, verticalPadding)
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
    CustomButton(isActiveClick: .constant(true), navigate: .constant(false), buttonText: "test")
}
