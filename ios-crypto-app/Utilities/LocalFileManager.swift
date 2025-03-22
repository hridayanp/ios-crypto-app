//
//  LocalFileManager.swift
//  ios-crypto-app
//
//  Created by Hridayan Phukan on 22/03/25.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()
    
    private init() {}
    
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        //CREATE FOLDER
        createFolderIfNotExists(folderName: folderName)
        
        // GET PATH TO IMAGE
        guard
                let data = image.pngData(),
                let url = getURLImageName(imageName: imageName, folderName: folderName)
        else { return }
        
       
       // SAVE IMAGE TO PATH
        do {
            try data.write(to: url)
        } catch let error {
            print("Saving image failed: \(error.localizedDescription)")
        }
    }
    
    func getImage(imageName: String, folderName: String)  -> UIImage?{
        guard
            let url = getURLImageName(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path)
        else { return nil }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNotExists(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating directory: \(error.localizedDescription)")
            }
        }
    }
    
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLImageName(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
