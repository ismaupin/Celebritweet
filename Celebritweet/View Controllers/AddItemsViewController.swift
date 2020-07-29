//
//  AddItemsViewController.swift
//  Celebritweet
//
//  Created by Isaac Maupin on 7/25/20.
//  Copyright © 2020 Isaac Maupin. All rights reserved.
//

import Foundation
import Cocoa


class AddItemsViewController: NSViewController, NSTextFieldDelegate {
    
    @IBOutlet var celebrityNameTextFiled: NSTextField!
    @IBOutlet var selectFileButton: NSButton!
    @IBOutlet var deleteTweetPopUp: NSPopUpButton!
    @IBOutlet var saveButton: NSButton!
    
    
    
    var store: MenuStore!
    var tweetOne: NSImageView!
    var tweetTwo: NSImageView!
    
    
    
    
    override func viewDidLoad() {
        deleteTweetPopUp.removeAllItems()
        deleteTweetPopUp.addItems(withTitles: store.menuItems)
        saveButton.isEnabled = false
        selectFileButton.isEnabled = false
       
    }
    
    override func viewWillAppear() {
        
        super.viewDidAppear()
        self.view.window?.standardWindowButton(NSWindow.ButtonType.closeButton)!.isHidden = true
        self.view.window?.standardWindowButton(NSWindow.ButtonType.miniaturizeButton)!.isHidden = true
        self.view.window?.standardWindowButton(NSWindow.ButtonType.zoomButton)!.isHidden = true
        celebrityNameTextFiled.delegate = self
        
    }
    
    func controlTextDidChange(_ obj: Notification) {
        selectFileButton.isEnabled = true
    }
 
    
    @IBAction func saveButtonClicked(_ sender: NSButton) {
        
        
        guard let inputName = celebrityNameTextFiled?.stringValue else {
            return
        }
        
        let enteredText = String(inputName)
        
      store.menuItems.append(enteredText)
        
        self.view.window?.windowController?.close()
        performSegue(withIdentifier: "itemAddClose", sender: sender)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        let controlView = segue.destinationController as! ControlsViewController
        controlView.store = store
        controlView.celebTweetOne = tweetOne
        controlView.celebTweetTwo = tweetTwo
    }
    
    override func viewWillDisappear() {
        // persist newly added data
        store.saveChanges()
        
    }
    
    @IBAction func selectFileTapped(_ sender: NSButton) {
        guard let window = view.window else { return}
        
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowsMultipleSelection = false
        
        panel.beginSheetModal(for: window) {
            (result) in if result == NSApplication.ModalResponse.OK {
                //save the image to the urls for use later
                
                if self.celebrityNameTextFiled?.stringValue != nil {
                    self.store.imageURLs.updateValue(panel.urls[0], forKey: self.celebrityNameTextFiled.stringValue)
                    Bookmarks.saveBookmarkData(for: panel.urls[0], name: self.celebrityNameTextFiled.stringValue)
                }
                self.saveButton.isEnabled = true
            }
        }
    }
    
    
    @IBAction func deleteTweet(_ sender: NSPopUpButtonCell) {
        guard let item = sender.selectedItem?.title else{ return}
        store.imageURLs.removeValue(forKey: item)
        
        let menuIndex = store.menuItems.firstIndex(of: item)
        store.menuItems.remove(at: menuIndex!)
        
        self.view.window?.windowController?.close()
        performSegue(withIdentifier: "itemAddClose", sender: sender)
        
    }
    
    
    
    
}
