//
//  Bookmarks.swift
//  Celebritweet
//
//  Created by Isaac Maupin on 7/28/20.
//  Copyright © 2020 Isaac Maupin. All rights reserved.
//

import Foundation
import Cocoa



struct Bookmarks {
    
    static func saveBookmarkData(for workDir: URL, name: String) {
        do{
            let bookmarkData = try workDir.bookmarkData(options: .withSecurityScope, includingResourceValuesForKeys: nil, relativeTo: nil)
            
            // Save in User defaults
            UserDefaults.standard.set(bookmarkData, forKey: name)
            
        }
        catch {
            print("failed to save bookmarkdata")
            
        }
    }
    
}
