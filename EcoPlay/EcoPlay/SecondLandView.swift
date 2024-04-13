//
//  LandView.swift
//  EcoPlay
//
//  Created by Rocco Del Prete on 11/04/2024.
//

import SwiftUI
import NavigationTransitions

struct SecondLandView: View {
    @State private var showSettings = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                if showSettings {
                    SettingsView(isActive: $showSettings)
                        .background(Color.darkGreen.opacity(0.6))
                        .zIndex(200.0)
                }
                VStack {
                    Spacer()
                    HStack(alignment: .center, spacing: 1) {
                        NavigationLink(destination: FirstLandView(), label: {
                            Image(systemName: "play.fill")
                                .foregroundStyle(Color(red: 27/255, green: 51/255, blue: 28/255))
                                .imageScale(.large)
                                .font(.system(size: 50))
                                .rotationEffect(.degrees(180))
                        })
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
                                            .background(Color(red: 27/255, green: 51/255, blue: 28/255))
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
                                            .background(Color(red: 27/255, green: 51/255, blue: 28/255))
                                            .clipShape(RoundedRectangle(cornerRadius: 5))
                                    }
                                }
                                Spacer()
                            }
                            .frame(width: 286, height: 324)
                            .background(Color(red: 219/255, green: 225/255, blue: 169/255))
                            .clipShape(RoundedRectangle(cornerRadius: 21.0))
                            .shadow(color: Color(red: 27/255, green: 51/255, blue: 28/255), radius: 0, x: 0, y: 8)
                            Spacer()
                        }
                        .frame(width: 286, height: 324)
                        .background(Color(red: 219/255, green: 225/255, blue: 169/255))
                        .clipShape(RoundedRectangle(cornerRadius: 21.0))
                        .shadow(color: Color(red: 27/255, green: 51/255, blue: 28/255), radius: 0, x: 0, y: 8)
                    }
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
                    }).shadow(color: Color(red: 0, green: 129/255, blue: 31/255), radius: 0, x: 0, y: 10)
                        .overlay(RoundedRectangle(cornerRadius: 33.0).stroke(.white, lineWidth: 3))
                        .padding(.top, 40)
                    Spacer()
                }
            }
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Color.backgroundGreen)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSettings.toggle()
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(Color.darkGreen)
                    }
                }
                ToolbarItem (placement: .principal, content: {
                    Text("play".uppercased())
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
        }
        .navigationTransition(.slide(axis: .horizontal).animation(.easeInOut(duration: 0.5)))
    }
}

#Preview {
    SecondLandView()
}
