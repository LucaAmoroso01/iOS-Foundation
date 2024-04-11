//
//  ContentView.swift
//  EcoPlay
//
//  Created by Rocco Del Prete on 11/04/2024.
//

import SwiftUI
import SwiftUIGIF


struct ContentView: View {
    @State private var imageData: Data?
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image("logo")
                    .resizable()
                    .frame(width: 280, height: 250)
                Spacer()
                NavigationLink(destination: LandView(), label: {
                    if let data = imageData {
                        GIFImage(data: data)
                            .padding(40)
                            .background(.white)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .frame(width: 300, height: 250)
                            .shadow(color: Color(red: 0/255, green: 129/255, blue: 31/255), radius: 0, x: 4, y: 10)
                    }
                })
                .buttonStyle(PlainButtonStyle())
                .onAppear(perform: {
                    loadData()
                })
                Spacer()
            }
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Color(red: 153.0/255, green: 206.0/255, blue: 119.0/255, opacity: 100))
        }
    }
    
    private func loadData() {
        let url = Bundle.main.url(forResource: "recycle", withExtension: "gif")?.absoluteString
        
        let task = URLSession.shared.dataTask(with: URL(string: url!)!) { data, response, error in
            imageData = data
        }
        task.resume()
    }
}

#Preview {
    ContentView()
}
