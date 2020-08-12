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
    
    @IBOutlet var celebrityNameTextField: NSTextField!
    @IBOutlet var selectFileButton: NSButton!
    @IBOutlet var deleteTweetPopUp: NSPopUpButton!
    @IBOutlet var saveButton: NSButton!
    
    var store: MenuStore!

    override func viewDidLoad() {
        deleteTweetPopUp.removeAllItems()
        deleteTweetPopUp.addItems(withTitles: store.menuItems)
        saveButton.isEnabled = false
        selectFileButton.isEnabled = false
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        celebrityNameTextField.delegate = self
    }
    
    func controlTextDidChange(_ obj: Notification) {
        selectFileButton.isEnabled = true
    }
 
    
    @IBAction func saveButtonClicked(_ sender: NSButton) {
        guard let inputName = celebrityNameTextField?.stringValue else { return }
        let enteredText = String(inputName)
        
      store.menuItems.append(enteredText)
        store.saveChanges()
        parent?.viewDidLoad()
        parent?.viewWillAppear()
        dismiss(self)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        let controlView = segue.destinationController as! ControlsViewController
        controlView.store = store
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
        panel.allowedFileTypes = NSImage.imageTypes
        
        panel.beginSheetModal(for: window) {
            (result) in if result == NSApplication.ModalResponse.OK {
                //save the image to the urls for use later
                
                if self.celebrityNameTextField?.stringValue != nil {
                    self.store.imageURLs.updateValue(panel.urls[0], forKey: self.celebrityNameTextField.stringValue)
                    Bookmarks.saveBookmarkData(for: panel.urls[0], name: self.celebrityNameTextField.stringValue)
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
        store.saveChanges()
        parent?.viewDidLoad()
        parent?.viewWillAppear()
        dismiss(self)

        
    }
}
