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
        
        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        // Update popUpButtons
        if store.menuItems.isEmpty {
            
            store.menuItems = store.imageURLs.map {$0.key}
        }
        
        celebrityOneMenu.addItems(withTitles: store.menuItems)
        celebrityTwoMenu.addItems(withTitles: store.menuItems)
        
    }
    
    // MARK: action methods
    
    @IBAction func celebOneAction(_ sender: NSPopUpButton) {
        // make sure the image path is an image and set the celebTweetOne to display it
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
    }
    
    @IBAction func celebTwoAction(_ sender: NSPopUpButton) {
        // make sure the image path is an image and set the celebTweetTwo to display it
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
        
        
        
    }
    
    // MARK: new window methods
    
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
    
    // MARK: restore access to files outside of the sandbox
    
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
