//
//  ViewController.swift
//  Celebritweet
//
//  Created by Isaac Maupin on 7/24/20.
//  Copyright © 2020 Isaac Maupin. All rights reserved.
//

import Cocoa
import RxSwift

class ViewController: NSViewController, NSImageDelegate  {
    
    @IBOutlet var imageStackView: NSStackView!
    @IBOutlet var tweetOne: NSImageView!
    @IBOutlet var tweetTwo: NSImageView!
    var tweetThree: NSImageView!
    var tweetFour: NSImageView!
    var aLabel: NSTextField!
    var bLabel: NSTextField!
    var cLabel: NSTextField!
    var dLabel: NSTextField!
    var aStackView: NSStackView!
    var bStackView: NSStackView!
    
    let disposeBag = DisposeBag()
    
    override func viewWillAppear() {
        super.viewWillAppear()
        tweetOne.image?.delegate = self
        tweetTwo.image?.delegate = self
        self.view.window?.standardWindowButton(NSWindow.ButtonType.closeButton)!.isHidden = true
    
    }
    //MARK: Layout View -
    override func viewDidLoad() {
        super.viewDidLoad()
        aLabel = NSTextField()
        bLabel = NSTextField()
        cLabel = NSTextField()
        dLabel = NSTextField()
        aStackView = NSStackView()
        bStackView = NSStackView()
        tweetThree = NSImageView()
        tweetFour = NSImageView()
        self.view.wantsLayer = true
        let backgroundImage = NSImage(resource: .background)
        self.view.layer!.contents = backgroundImage
        // Do any additional setup after loading the view.
        
        view.addSubview(imageStackView)
        imageStackView.addView(aStackView, in: .center)
        imageStackView.addView(bStackView, in: .center)
        imageStackView.orientation = .horizontal
        
        aStackView.orientation = .vertical
        aStackView.addView(aLabel, in: .center)
        aStackView.addView(tweetOne, in: .center)
        aStackView.addView(cLabel, in: .center)
        aStackView.addView(tweetThree, in: .center)
        aStackView.spacing = 8
        
        bStackView.orientation = .vertical
        bStackView.addView(bLabel, in: .center)
        bStackView.addView(tweetTwo, in: .center)
        bStackView.addView(dLabel, in: .center)
        bStackView.addView(tweetFour, in: .center)
        bStackView.spacing = 8
        
        aLabel.textColor = .white
        aLabel.backgroundColor = .none
        aLabel.isBezeled = false
        aLabel.drawsBackground = false
        aLabel.isEditable = false
        aLabel.font = NSFont(name: "helvetica", size: 40)
        aLabel.stringValue = "A"
        aLabel.alignment = .center
        
        bLabel.textColor = .white
        bLabel.backgroundColor = .none
        bLabel.isBezeled = false
        bLabel.drawsBackground = false
        bLabel.isEditable = false
        bLabel.font = NSFont(name: "helvetica", size: 40)
        bLabel.stringValue = "B"
        bLabel.alignment = .center
        
        
        cLabel.textColor = .white
        cLabel.backgroundColor = .none
        cLabel.isBezeled = false
        cLabel.drawsBackground = false
        cLabel.isEditable = false
        cLabel.font = NSFont(name: "helvetica", size: 40)
        cLabel.stringValue = "C"
        cLabel.alignment = .center
        
        
        dLabel.textColor = .white
        dLabel.backgroundColor = .none
        dLabel.isBezeled = false
        dLabel.drawsBackground = false
        dLabel.isEditable = false
        dLabel.font = NSFont(name: "helvetica", size: 40)
        dLabel.stringValue = "D"
        aLabel.alignment = .center
        
        let stackViewTop = imageStackView.topAnchor.constraint(equalTo: view.topAnchor)
        let stackViewBottom = imageStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let stackViewCenter = imageStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let stackViewLeading = imageStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let stackViewTrailing = imageStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        stackViewTop.isActive = true
        stackViewBottom.isActive = true
        stackViewCenter.isActive = true
        stackViewLeading.isActive = true
        stackViewTrailing.isActive = true
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.orientation = .horizontal
        imageStackView.spacing = 10
        imageStackView.distribution = .fillEqually
        imageStackView.edgeInsets.left = 8
        imageStackView.edgeInsets.right = 8
//        imageStackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//        imageStackView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        tweetOne.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        tweetTwo.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        tweetOne.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        tweetTwo.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        tweetThree.setContentCompressionResistancePriority( .defaultLow, for: .horizontal)
        tweetThree.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        tweetFour.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        tweetFour.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        let tweetThreeWidth = tweetThree.heightAnchor.constraint(equalTo: tweetOne.heightAnchor)
        let tweetThreeHeight = tweetThree.widthAnchor.constraint(equalTo: tweetOne.widthAnchor)
        let tweetFourWidth = tweetFour.heightAnchor.constraint(equalTo: tweetTwo.heightAnchor)
        let tweetFourHeight = tweetFour.widthAnchor.constraint(equalTo: tweetTwo.widthAnchor)
        
        tweetThreeWidth.isActive = true
        tweetThreeHeight.isActive = true
        tweetFourWidth.isActive = true
        tweetFourHeight.isActive = true
        
//        aStackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//        aStackView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
//        bStackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//        bStackView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        tweetOne.image = NSImage(resource: .aoc)
        tweetTwo.image = NSImage(resource: .aoc)
        tweetThree.image = NSImage(resource: .kanye)
        tweetFour.image = NSImage(resource: .kermit)
    }
    
    @IBAction func controlWindowSelected (_ sender: Any) {
        performSegue(withIdentifier: "openControls", sender: sender)
    }
    
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        switch segue.identifier{
        case "openControls":
            
        let destinationVC = segue.destinationController as! ControlsViewController
        
        destinationVC.tweetOneObserver.subscribe(onNext: {
            [weak self] (image) in self?.tweetOne.image = image
        }).disposed(by: disposeBag)
        
        destinationVC.tweetTwoObserver.subscribe(onNext: {
            [weak self] (image) in self?.tweetTwo.image = image
        }).disposed(by: disposeBag)
            
        destinationVC.tweetThreeObserver.subscribe(onNext: {
            [weak self] (image) in self?.tweetThree.image = image
        })
        destinationVC.tweetFourObserver.subscribe(onNext: {
            [weak self] (image) in self?.tweetFour.image = image
        })
        
        default:
            break
        }
    }
    func imageDidNotDraw(_ sender: NSImage, in rect: NSRect) -> NSImage? {
        return NSImage(resource: .aoc)
    }
    
    
    @IBAction func timerWindowSelected (_ sender: Any) {
        performSegue(withIdentifier: "TimerSegue", sender: sender)
//        performSegue(withIdentifier: "TimerControls", sender: sender)
        
        
    }
    
}

