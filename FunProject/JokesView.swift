//
//  JokesView.swift
//  FunProject
//
//  Created by Wilda Akmalia on 31/07/23.
//

import Foundation
import SwiftUI

struct Jokes: Hashable, Codable {
    let type: String
    let setup: String
    let punchline: String
    let id: Int
}

class JokeViewModel : ObservableObject {
    @Published var jokes: Jokes = Jokes(type: "general", setup: "Your day too monochrome? Color it with your laughter!", punchline: "Lezzgo", id: 567)
    
    func fetchData() {
        guard let url = URL(string: "https://official-joke-api.appspot.com/random_joke") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Jokes.self, from: data)
                DispatchQueue.main.async {
                    self.jokes = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}


struct JokeApiView: View {
    @StateObject var jokeViewModel = JokeViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 100) {
                Text("\(jokeViewModel.jokes.setup) \n \(jokeViewModel.jokes.punchline)")
                    .navigationBarTitle("Jokes API", displayMode: .inline)
                
                Button(action: {
                    jokeViewModel.fetchData()
                },
                       label: {
                    Text("Generate Jokes")
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

struct JokeApiView_Previews: PreviewProvider {
    static var previews: some View {
        JokeApiView()
    }
}
