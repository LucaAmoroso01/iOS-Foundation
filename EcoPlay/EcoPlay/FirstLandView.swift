//
//  LandView.swift
//  EcoPlay
//
//  Created by Rocco Del Prete on 11/04/2024.
//

import SwiftUI

struct FirstLandView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 70) {
            Text("learn".uppercased())
                .padding(.horizontal, 35)
                .padding(.vertical, 5)
                .foregroundStyle(.white)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .kerning(2)
                .shadow(color: .black.opacity(25/100), radius: 2, x: 0, y: 4)
                .blur(radius: 0.4)
                .background(Color(red: 103/255, green: 235/255, blue: 0/255))
                .clipShape(RoundedRectangle(cornerRadius: 33.0))
                .overlay {
                    RoundedRectangle(cornerRadius: 33.0)
                        .stroke(.white, lineWidth: 3)
                }
                .padding(.top, 3)
            HStack(alignment: .center, spacing: 1) {
                VStack(alignment: .center) {
                    Text("recycle \ncircle".uppercased())
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
                                Color(red: 27/255, green: 51/255, blue: 28/255)
                            ]
                                    )
                        )
                        .clipShape(Circle())
                        .padding(25)
                    Spacer()
                }
                .frame(width: 286, height: 324)
                .background(Color(red: 219/255, green: 225/255, blue: 169/255))
                .clipShape(RoundedRectangle(cornerRadius: 21.0))
                .shadow(color: Color(red: 27/255, green: 51/255, blue: 28/255), radius: 0, x: 0, y: 8)
                Image(systemName: "play.fill")
                    .foregroundStyle(Color(red: 27/255, green: 51/255, blue: 28/255))
                    .imageScale(.large)
                    .font(.system(size: 50))
            }
            .padding(.top, 80)
            Button(action: {}, label: {
                Text("Start")
                    .font(Font.custom("Play-Bold", size: 24))
                    .kerning(2)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(25/100), radius: 2, x: 0, y: 4)
                    .blur(radius: 0.4)
                    .background(Color(red: 103/255, green: 235/255, blue: 0/255))
                    .clipShape(RoundedRectangle(cornerRadius: 33.0))
                    .zIndex(200)
            }).shadow(color: Color(red: 0, green: 129/255, blue: 31/255), radius: 0, x: 0, y: 10).zIndex(100)
                .overlay(RoundedRectangle(cornerRadius: 33.0).stroke(.white, lineWidth: 3))
            Spacer()
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Color(Color(red: 153.0/255, green: 206.0/255, blue: 119.0/255, opacity: 100)))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}, label: {
                    Image(systemName: "gearshape.fill")
                        .colorMultiply(Color(red: 27/255, green: 51/255, blue: 28/255))
                })
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    FirstLandView()
}
