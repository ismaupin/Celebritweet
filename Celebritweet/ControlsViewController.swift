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
    var store = MenuStore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        celebrityOneMenu.removeAllItems()
        celebrityTwoMenu.removeAllItems()
//       if (celebrityOneMenu.item(withTitle: "AOC") != nil){
//           celebrityOneMenu.removeItem(withTitle: "AOC")
//       }
//
//        if (celebrityOneMenu.item(withTitle: "Item 2") != nil){
//            celebrityOneMenu.removeItem(withTitle: "Item 2")
//        }
//
//        if (celebrityOneMenu.item(withTitle: "Item 3") != nil){
//            celebrityOneMenu.removeItem(withTitle: "Item 3")
//        }
//
//        if (celebrityTwoMenu.item(withTitle: "AOC") != nil){
//                          celebrityTwoMenu.removeItem(withTitle: "AOC")
//                      }
//
//        if (celebrityTwoMenu.item(withTitle: "Item 2") != nil){
//                   celebrityTwoMenu.removeItem(withTitle: "Item 2")
//               }
//
//               if (celebrityTwoMenu.item(withTitle: "Item 3") != nil){
//                   celebrityTwoMenu.removeItem(withTitle: "Item 3")
//               }
//
   }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        if store.menuItems.isEmpty {
            
            store.menuItems = store.imageURLs.map {$0.key}
            
//                 store.menuItems += ["AOC", "Julie Andrews", "Kermit", "Lin Manuel Miranda", "Pat Sajack", "Britney Spears", "Trump", "Kanye" ]
             }
        
       celebrityOneMenu.addItems(withTitles: store.menuItems)
       celebrityTwoMenu.addItems(withTitles: store.menuItems)
    
    }
    
    
    @IBAction func celebOneAction(_ sender: NSPopUpButton) {
        guard let item = sender.selectedItem else{return}
        let itemTitle = item.title
        let bookmarkData = UserDefaults.standard.data(forKey: itemTitle)
        guard let data = bookmarkData else{return}
        let bookmarkURL = restoreFileAccess(withBookmarkdata: data, name: itemTitle)
        guard let imageURL = bookmarkURL else{return}
        guard let tweetImage = NSImage(contentsOf: imageURL) else {return}
        if tweetImage.isValid {
        
        celebTweetOne.image = tweetImage
        }
        else { print ("image is invallid")}
//        switch celebrityOneMenu.selectedItem?.title {
//        case "AOC"
//            celebTweetOne.image = NSImage(resource: .aoc)
//        case "Julie Andrews":
//            celebTweetOne.image = NSImage(resource: .julieAndrews)
//        case "Kermit":
//            celebTweetOne.image = NSImage(resource: .kermit)
//        case "Lin Manuel Miranda":
//            celebTweetOne.image = NSImage(resource: .linManuelMiranda)
//        case "Pat Sajack":
//            celebTweetOne.image = NSImage(resource: .patSajack)
//        case "Britney Spears":
//            celebTweetOne.image = NSImage(resource: .britneySpears)
//        case "Trump":
//            celebTweetOne.image = NSImage(resource: .trump)
//        case "Kanye":
//            celebTweetOne.image = NSImage(resource: .kanye)
//
//        case "Elizabeth Warren":
//            celebTweetOne.image = NSImage(byReferencing: store.imageURLs["Elizabeth Warren"]!)
//        default:
//            break
//        }
    
    }
    
    @IBAction func celebTwoAction(_ sender: NSPopUpButton) {
        guard let item = sender.selectedItem else{return}
               let itemTitle = item.title
            let bookmarkData = UserDefaults.standard.data(forKey: itemTitle)
            guard let data = bookmarkData else {return}
               let bookmarkURL = restoreFileAccess(withBookmarkdata: data, name: itemTitle)
               guard let imageURL = bookmarkURL else{return}
               guard let tweetImage = NSImage(contentsOf: imageURL) else {return}
               if tweetImage.isValid {
               
               celebTweetTwo.image = tweetImage
               }
               else { print ("image is invallid")}
//        guard let item = sender.selectedItem else{return}
//        let itemTitle = item.title
//        guard let imageURL = store.imageURLs[itemTitle] else{return}
//
//        celebTweetTwo.image = NSImage(contentsOf: imageURL)
//
        
        //  switch celebrityTwoMenu.selectedItem?.title {
//       case "AOC":
//           celebTweetTwo.image = NSImage(resource: .aoc)
//       case "Julie Andrews":
//           celebTweetTwo.image = NSImage(resource: .julieAndrews)
//       case "Kermit":
//           celebTweetTwo.image = NSImage(resource: .kermit)
//       case "Lin Manuel Miranda":
//           celebTweetTwo.image = NSImage(resource: .linManuelMiranda)
//       case "Pat Sajack":
//           celebTweetTwo.image = NSImage(resource: .patSajack)
//       case "Britney Spears":
//           celebTweetTwo.image = NSImage(resource: .britneySpears)
//       case "Trump":
//           celebTweetTwo.image = NSImage(resource: .trump)
//       case "Kanye":
//           celebTweetTwo.image = NSImage(resource: .kanye)
//        case "Elizabeth Warren":
//            celebTweetTwo.image = NSImage(byReferencing: store.imageURLs["Elizabeth Warren"]!)
//       default:
//           break
//       }
//
    
    
    }
    
    @IBAction func addItemButtonClicked(_ sender: NSButton) {
        
        performSegue(withIdentifier: "addItems", sender: sender)
        
view.window?.windowController?.close()
    }
    
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        let addItemsViewController = segue.destinationController as! AddItemsViewController
        
        addItemsViewController.store = store
        addItemsViewController.tweetOne = celebTweetOne
        addItemsViewController.tweetTwo = celebTweetTwo
        
        self.addChild(addItemsViewController)
    }
    
    private func restoreFileAccess(withBookmarkdata: Data, name: String)->URL?{
        do {
            var isStale = false
            let url = try URL(resolvingBookmarkData: withBookmarkdata, options: .withSecurityScope, relativeTo: nil, bookmarkDataIsStale: &isStale)
            if isStale {
                print("bookmark is stale time to update it")
                Bookmarks.saveBookmarkData(for: url, name: name)
            }
            if !url.startAccessingSecurityScopedResource(){
                print ("startAccessingSecurityScopedResource returned false. This directory might not need it, or this URL might not be a security scoped URL, or maybe something's wrong?")
            }
            return url
        } catch {
            print("Error resloving bookmark: \(error)")
            return nil
        }
        
    }
    
}
