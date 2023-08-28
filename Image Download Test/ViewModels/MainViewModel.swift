//
//  MainViewModel.swift
//  Image Download Test
//
//  Created by Demir Dereli on 28.08.2023.
//

import Foundation

class MainViewModel: ObservableObject {
    
    @Published var imageModels: [ImageModel] = []
    
    init() {
        getJSONData()
    }
    
    func getJSONData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
            fatalError("Could not create the URL.")
        }
        
        URLSession.shared.dataTask(with: url) {data,response,error in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error Downlading Data")
                return
            }
            
            guard let JSONDataArray = try? JSONDecoder().decode([ImageModel].self, from: data) else {return}
            
            DispatchQueue.main.async { [weak self] in
                self?.imageModels = JSONDataArray
            }
            
        }.resume()
    }
    
}
