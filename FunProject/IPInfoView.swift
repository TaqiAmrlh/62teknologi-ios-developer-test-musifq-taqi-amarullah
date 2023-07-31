//
//  IPInfoView.swift
//  FunProject
//
//  Created by Wilda Akmalia on 31/07/23.
//

import Foundation
import SwiftUI

struct LocationInfo : Hashable, Codable {
    let ip: String
    let city: String
    let region: String
    let country: String
    let loc: String
    let org: String
    let postal: String
    let timezone: String
    let readme: String
}

class LocationInfoViewModel : ObservableObject {
    @Published var location : LocationInfo = LocationInfo(
        ip: "",
        city: "",
        region: "",
        country: "",
        loc: "",
        org: "",
        postal: "",
        timezone: "",
        readme: "")
    
    @Published var ip = ""
    
    func fetchData() {
        guard let url = URL(string: "https://ipinfo.io/\(ip)/geo") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(LocationInfo.self, from: data)
                DispatchQueue.main.async {
                    self.location = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}

struct IPInfoView: View {
    @StateObject var locationViewModel = LocationInfoViewModel()
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 35) {
                VStack {
                    Text("City : \(locationViewModel.location.city)")
                        .frame(width: 280, alignment: .leading)
                    Text("Region : \(locationViewModel.location.region)")
                        .frame(width: 280, alignment: .leading)
                    Text("Country : \(locationViewModel.location.country)")
                        .frame(width: 280, alignment: .leading)
                    Text("Location : \(locationViewModel.location.loc)")
                        .frame(width: 280, alignment: .leading)
                }
                    
                
                VStack {
                    TextField("Insert the ip here", text: $locationViewModel.ip)
                        .padding()
                        .background(Color.gray.opacity(0.5))
                        .frame(width: 300, height: 50)
                        .cornerRadius(15)
                        
                    Text("e.g 192.168.201.43")
                        .frame(width: 300, alignment: .leading)
                        .font(.system(size: 15))
                        .opacity(0.2)
                        .padding(.leading, 30)
                }
                
                    
                    Button(action: {
                        locationViewModel.fetchData()
                    },
                           label: {
                        Text("Show Location Info")
                            .bold()
                            .frame(width: 300, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    })
                
                
                
            }
            .navigationBarTitle("IP Info Location", displayMode: .inline)
            }
        }
}

struct IPInfoView_Previews: PreviewProvider {
    static var previews: some View {
        IPInfoView()
    }
}
