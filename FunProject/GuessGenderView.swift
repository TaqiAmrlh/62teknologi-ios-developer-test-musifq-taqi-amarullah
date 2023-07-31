//
//  GuessGenderView.swift
//  FunProject
//
//  Created by Wilda Akmalia on 31/07/23.
//

import Foundation
import SwiftUI

struct Persons: Hashable, Codable {
    let count: Int
    let name: String
    let gender: String?
    let probability: Double?
}

class GenderViewModel : ObservableObject {
    @Published var persons : Persons = Persons(count: 0, name: "", gender: "", probability: nil)
    
    @Published var name = ""
    
    func fetchData() {
        guard let url = URL(string: "https://api.genderize.io/?name=\(name)") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Persons.self, from: data)
                DispatchQueue.main.async {
                    self.persons = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}


struct GuessGenderView: View {
    @StateObject var genderViewModel = GenderViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 10) {
                    Text("Your Gender Is:")
                        .padding()
                        .font(.system(size: 50, weight: .thin))
                        .navigationBarBackButtonHidden(true)
                        .navigationTitle("GUESS GENDER")
                        .navigationBarTitleDisplayMode(.inline)
                    
                    if let genders = genderViewModel.persons.gender {
                        Text("\(genders)")
                            .padding()
                            .font(.system(size: 40, weight: .bold))
                    } else {
                        Text("NaN")
                            .padding()
                            .font(.system(size: 50, weight: .bold))
                    }
                }
                
                TextField("Insert the name here", text: $genderViewModel.name)
                    .padding()
                    .background(Color.gray)
                    .frame(width: 300, height: 50)
                
                Button(action: {
                    genderViewModel.fetchData()
                },
                       label: {
                    Text("Show your gender")
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

struct GuessGender_Previews: PreviewProvider {
    static var previews: some View {
        GuessGenderView()
    }
}
