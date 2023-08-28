//
//  JSONDownloadManager.swift
//  Image Download Test
//
//  Created by Demir Dereli on 28.08.2023.
//

import Foundation
import SwiftUI

class ItemViewModel: ObservableObject {
    let url: String
    let folderName = "Photos"
    @Published var image: UIImage?
    
    init(url: String) {
        self.url = url
        downloadImage(url: url)
    }
    
    func downloadImage(url: String) {
        let key = url
        guard let url = URL(string: url) else {
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
            
            guard let image = UIImage(data: data) else {
                print("Failed converting Data to Image")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    private func getPhotosURL() -> URL? {
        let url = FileManager.default.urls(for: .documentDirectory , in: .userDomainMask)[0]
        let photosURL = url.appendingPathComponent(folderName)
        return photosURL
    }
    
    private func createFolderIfNeeded() {
        guard let url = getPhotosURL() else {return}
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error{
                print(error)
            }
        }
    }
    
    private func getImageURL(key: String) -> URL? {
        guard let folder = getPhotosURL() else {return nil}
        let imageURL = folder.appendingPathComponent(key + ".png")
        return imageURL
    }
    
     func saveImageToPhotosFolder(image: UIImage, key: String){
        createFolderIfNeeded()
        guard let image = image.pngData() else {return}
        guard let imageURL = getImageURL(key: key) else {return}
        
        do {
            try image.write(to: imageURL)
        } catch let error {
            print("Error saving to file manager \(error)")
        }
    }
    
    func getImageFromPhotosFolder(key: String) -> UIImage? {
        guard let url = getImageURL(key: key), FileManager.default.fileExists(atPath: url.path) else {return nil}
        return UIImage(contentsOfFile: url.path)
    }

    
    
}















