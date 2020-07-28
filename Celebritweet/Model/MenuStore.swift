//
//  MenuStore.swift
//  Celebritweet
//
//  Created by Isaac Maupin on 7/25/20.
//  Copyright © 2020 Isaac Maupin. All rights reserved.
//

import Foundation
import Cocoa


class MenuStore {
   
    
    
    var menuItems: [String] = []
    var imageURLs: [String: URL] = [:]
    
    let archiveURL: URL = {
    
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("resources.plist")
    
    }()
    
    init() {
        // repopulate store dictionaries from persisted plist when they are initialized
        do {
            let data = try Data(contentsOf: archiveURL)
            let unarchiver = PropertyListDecoder()
            let tweets = try unarchiver.decode([String: URL].self, from: data)
            imageURLs = tweets
            print(imageURLs.description)
            
        }catch{
            print("error reading saved items")
        }
    }
     @discardableResult func saveChanges() -> Bool{
       
        do{
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(imageURLs)
            try data.write(to: archiveURL, options: .atomic)
            print("persisted tweet paths to \(archiveURL)")
            return true
        } catch {
            print("error saving tweet paths \(error)")
            return false
        }
    }
    
  
   
}
