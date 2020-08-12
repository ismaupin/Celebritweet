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
        self.view.wantsLayer = true
        let backgroundImage = NSImage(resource: .background)
        self.view.layer!.contents = backgroundImage
        // Do any additional setup after loading the view.
        
        view.addSubview(imageStackView)
        imageStackView.addView(tweetOne, in: .center)
        imageStackView.addView(tweetTwo, in: .center)
        
        
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
        imageStackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        imageStackView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        tweetOne.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        tweetTwo.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        tweetOne.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        tweetTwo.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        tweetOne.image = NSImage(resource: .aoc)
        tweetTwo.image = NSImage(resource: .aoc)
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

