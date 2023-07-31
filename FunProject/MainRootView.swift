//
//  MainRootView.swift
//  FunProject
//
//  Created by Wilda Akmalia on 31/07/23.
//

import Foundation
import SwiftUI

struct MainRootView: View {
    private var data: [Int] = Array(1...6)
    private let colors: [Color] = [.red, .yellow, .blue, .green]
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: adaptiveColumns, spacing: 25) {
                    NavigationLink(destination: CatView()) {
                        CardView(color: Color.yellow, title: "Cat Fact")
                    }
                    
                    NavigationLink(destination: AgeView()) {
                        CardView(color: Color.orange, title: "Guess My Age")
                    }
                    
                    NavigationLink(destination: DogView()) {
                        CardView(color: Color.red, title: "Cute Dogs")
                    }
                    
                    NavigationLink(destination: JokeApiView()) {
                        CardView(color: Color.purple, title: "Funny Jokes")
                    }
                    
                    NavigationLink(destination: GuessGenderView()) {
                        CardView(color: Color.blue, title: "Guess My Gender")
                    }
                    
                    NavigationLink(destination: IPInfoView()) {
                        CardView(color: Color.green, title: "IP Info")
                    }
                }
                .padding()
            }
            .navigationTitle("Main Menu")
        }
        .accentColor(.white)
    }
}

struct CardView: View {
    var color: Color
    var title: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(color)
                .frame(width: 170, height: 170)
                .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
            
            VStack {
                Text(title)
                    .font(.custom("Baskerville-Bold", size: 30))
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}

struct MainRootView_Previews: PreviewProvider {
    static var previews: some View {
        MainRootView()
    }
}
