//
//  NSImage + tweets.swift
//  Celebritweet
//
//  Created by Isaac Maupin on 7/24/20.
//  Copyright © 2020 Isaac Maupin. All rights reserved.
//

import Foundation

import Cocoa

enum ImageResource: String {
    
    case aoc
    case julieAndrews
    case linManuelMiranda
    case kermit
    case britneySpears
    case trump
    case kanye
    case patSajack
    case background
    
    
    
}


extension NSImage {
    
    convenience init(resource: ImageResource){
        self.init(named: resource.rawValue)!
    }
    
}
