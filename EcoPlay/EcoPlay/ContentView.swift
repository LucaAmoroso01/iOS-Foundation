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
                    FirstLandView()
                }
            )
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Color(red: 153.0/255, green: 206.0/255, blue: 119.0/255, opacity: 1.0))
            .navigationBarHidden(true)
            .onAppear {
                loadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    shouldNavigate = true
                }
            }
        }
        .navigationTransition(
            .fade(.in).combined(with: .fade(.cross))
            .animation(.easeIn(duration: 0.8))
        )
        .background(
            Gradient(colors: [
                Color.white
                // Color(red: 81/255, green: 139/255, blue: 84/255),
                // Color(red: 27/255, green: 51/255, blue: 28/255)
            ])
        )
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

#Preview {
    ContentView()
}
