//
//  CuteDogsView.swift
//  FunProject
//
//  Created by Wilda Akmalia on 31/07/23.
//

import Foundation
import SwiftUI

struct Dog: Hashable, Codable {
    let message: String
    let status: String
}

class DogViewModel : ObservableObject {
    @Published var dogs : Dog = Dog(message: "https://media.istockphoto.com/id/1135504943/photo/cute-beagle-dog-sitting-on-a-brown-welcome-mat.jpg?s=612x612&w=0&k=20&c=C_diArGt7wGheThdVVK9fbc1PAYX2mC1c_9AYPgfKJA=", status: "success")
    
    func fetchData() {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Dog.self, from: data)
                DispatchQueue.main.async {
                    self.dogs = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}

struct DogView: View {
    @StateObject var dogViewModel = DogViewModel()
    @State private var isButtonPressed = false // Langkah 1: Tambahkan variabel isButtonPressed
    
    var body: some View {
        NavigationView {
            VStack(spacing: 100) {
                AsyncImage(url: URL(string: dogViewModel.dogs.message)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300, alignment: .center)
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.blue)
                }
                .frame(width: 500, height: 250)
                
                .navigationBarTitle("Dog Picts", displayMode: .inline)
                
                Button(action: {
                    dogViewModel.fetchData()
                    isButtonPressed = true // Langkah 3: Set variabel isButtonPressed menjadi true setelah tombol ditekan
                }, label: {
                    Text(isButtonPressed ? "More cute dogs!" : "Summon the cute dogs!") // Langkah 2: Ubah label menggunakan operator ternary
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

struct DogView_Previews: PreviewProvider {
    static var previews: some View {
        DogView()
    }
}
