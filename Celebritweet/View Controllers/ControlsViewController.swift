//
//  ControlsViewController.swift
//  Celebritweet
//
//  Created by Isaac Maupin on 7/24/20.
//  Copyright © 2020 Isaac Maupin. All rights reserved.
//

import Cocoa
import RxSwift

class ControlsViewController: NSViewController {
    
//MARK: Properties -
    @IBOutlet var celebrityOneMenu: NSPopUpButton!
    @IBOutlet var celebrityTwoMenu: NSPopUpButton!
    
    var store = MenuStore()

    let tweetOneSequence = PublishSubject<NSImage>()
    let tweetTwoSquence = PublishSubject<NSImage>()
    var tweetOneObserver:Observable<NSImage> {
        return tweetOneSequence.asObservable()
    }
    var tweetTwoObserver:Observable<NSImage> {
        return tweetTwoSquence.asObservable()
    }
    
// MARK: Methods -
// MARK: View Enterance Methods
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
    
// MARK: Action Methods
    
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
            tweetOneSequence.on(.next (tweetImage))
        }
        else { print ("image is invalid")}
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
            tweetTwoSquence.on(.next(tweetImage))
        }
        else { print ("image is invalid")}
    }
    
// MARK: New Window Methods
    
    @IBAction func addItemButtonClicked(_ sender: NSButton) {
        let sheet = storyboard?.instantiateController(withIdentifier: "AddItemsViewController") as! AddItemsViewController
        
        sheet.store = store
        self.addChild(sheet)
        self.presentAsSheet(sheet)

    }
    
// MARK: Restore Access to Bookmarked Files (files outside of the sandbox)
    
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
