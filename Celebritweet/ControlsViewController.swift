//
//  ControlsViewController.swift
//  Celebritweet
//
//  Created by Isaac Maupin on 7/24/20.
//  Copyright © 2020 Isaac Maupin. All rights reserved.
//

import Cocoa

class ControlsViewController: NSViewController {
    @IBOutlet var celebrityOneMenu: NSPopUpButton!
    @IBOutlet var celebrityTwoMenu: NSPopUpButton!
    
    var celebTweetOne: NSImageView!
    var celebTweetTwo: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
      
        
        let celebrities = ["AOC", "Julie Andrews", "Kermit", "Lin Manuel Miranda", "Pat Sajack", "Britney Spears", "Trump", "Kanye" ]
        
        celebrityOneMenu.removeAllItems()
        celebrityTwoMenu.removeAllItems()
        celebrityOneMenu.addItems(withTitles: celebrities)
        celebrityTwoMenu.addItems(withTitles: celebrities)
        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        
       
    }
    
    
    @IBAction func celebOneAction(_ sender: NSPopUpButton) {
    
        switch celebrityOneMenu.selectedItem?.title {
        case "AOC":
            celebTweetOne.image = NSImage(resource: .aoc)
        case "Julie Andrews":
            celebTweetOne.image = NSImage(resource: .julieAndrews)
        case "Kermit":
            celebTweetOne.image = NSImage(resource: .kermit)
        case "Lin Manuel Miranda":
            celebTweetOne.image = NSImage(resource: .linManuelMiranda)
        case "Pat Sajack":
            celebTweetOne.image = NSImage(resource: .patSajack)
        case "Britney Spears":
            celebTweetOne.image = NSImage(resource: .britneySpears)
        case "Trump":
            celebTweetOne.image = NSImage(resource: .trump)
        case "Kanye":
            celebTweetOne.image = NSImage(resource: .kanye)
        default:
            break
        }
    
    }
    
    @IBAction func celebTwoAction(_ sender: NSPopUpButton) {
  switch celebrityTwoMenu.selectedItem?.title {
       case "AOC":
           celebTweetTwo.image = NSImage(resource: .aoc)
       case "Julie Andrews":
           celebTweetTwo.image = NSImage(resource: .julieAndrews)
       case "Kermit":
           celebTweetTwo.image = NSImage(resource: .kermit)
       case "Lin Manuel Miranda":
           celebTweetTwo.image = NSImage(resource: .linManuelMiranda)
       case "Pat Sajack":
           celebTweetTwo.image = NSImage(resource: .patSajack)
       case "Britney Spears":
           celebTweetTwo.image = NSImage(resource: .britneySpears)
       case "Trump":
           celebTweetTwo.image = NSImage(resource: .trump)
       case "Kanye":
           celebTweetTwo.image = NSImage(resource: .kanye)
       default:
           break
       }
   
    
    
    }
    
}
