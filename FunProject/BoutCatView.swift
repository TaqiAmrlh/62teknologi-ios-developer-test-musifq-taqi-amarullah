//
//  BoutCatView.swift
//  FunProject
//
//  Created by Wilda Akmalia on 31/07/23.
//

import Foundation
import SwiftUI

struct Cat: Hashable, Codable {
    let fact: String
    let length: Int
}

class CatViewModel : ObservableObject {
    @Published var cats : Cat = Cat(fact: "I'll give you some fun facts about cats!", length: 90)
    
    func fetchData() {
        guard let url = URL(string: "https://catfact.ninja/fact") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Cat.self, from: data)
                DispatchQueue.main.async {
                    self.cats = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}

struct CatView: View {
    @StateObject var catViewModel = CatViewModel()
    @State private var isButtonPressed = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 100) {
                Text("Why you should have a cat? \n \(catViewModel.cats.fact)")
                    .navigationBarTitle("Cat Facts", displayMode: .inline)
                
                Button(action: {
                    catViewModel.fetchData()
                    isButtonPressed = true
                },
                       label: {
                    Text(isButtonPressed ? "More fact!" : "Give me fact!")
                        .bold()
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
            }
        }
        
    }
}

struct CatView_Previews: PreviewProvider {
    static var previews: some View {
        CatView()
    }
}

