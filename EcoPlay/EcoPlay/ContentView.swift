//
//  ContentView.swift
//  EcoPlay
//
//  Created by Rocco Del Prete on 11/04/2024.
//

import SwiftUI
import SwiftUIGIF
import NavigationTransitions

struct ContentView: View {
    @State private var imageData: Data?
    @State private var shouldNavigate = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundGreen.ignoresSafeArea()
                VStack {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .frame(width: 280, height: 250)
                    Spacer()
                    
                    if let data = imageData {
                        GIFImage(data: data)
                            .padding(40)
                            .background(Color.white)
                            .clipShape(Circle())
                            .frame(width: 300, height: 250)
                            .shadow(color: Color(red: 0/255, green: 129/255, blue: 31/255), radius: 0, x: 4, y: 10)
                    }
                    Spacer()
                }
                .navigationDestination(
                    isPresented: $shouldNavigate,
                    destination: {
                        LandsView()
                    }
                )
                .navigationBarHidden(true)
                .onAppear {
                    loadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        shouldNavigate.toggle()
                    }
                }
            }
        }
        .navigationTransition(.fade(.out).animation(.easeInOut(duration: 0.6)))
    }
    
    private func loadData() {
        guard let url = Bundle.main.url(forResource: "recycle", withExtension: "gif") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            imageData = data
        } catch {
            print("Error loading GIF data: \(error)")
        }
    }
}

extension Color {
    static let darkGreen = Color(red: 27/255, green: 51/255, blue: 28/255)
    
    static let backgroundTextGreen = Color(red: 103/255, green: 235/255, blue: 0/255)
    
    static let cardBackground = Color(red: 219/255, green: 225/255, blue: 169/255)
    
    static let backgroundGreen = Color(red: 153.0/255, green: 206.0/255, blue: 119.0/255, opacity: 100)
    
    static let backgroundImageGray = Color(red: 217/255, green: 217/255, blue: 217/255, opacity: 0.72)
}

#Preview {
    ContentView()
}
