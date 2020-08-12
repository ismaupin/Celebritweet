//
//  TimerViewContoller.swift
//  Celebritweet
//
//  Created by Isaac Maupin on 8/11/20.
//  Copyright © 2020 Isaac Maupin. All rights reserved.
//

import Foundation
import Cocoa
import RxSwift
import RxCocoa
import SnapKit


class TimerViewController: NSViewController {
    
    @IBOutlet var timerStackView: NSStackView!
    @IBOutlet var timerLabel: NSTextField!
    
    var timerControls: TimerControlsViewController!

    
//    var timerController: TimerControlsViewController?
    
    var timer: Double = 0.0
    // timer will reactively listen for the updates when the contols set, start, stop and reset the timer.
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
       
        
        super.viewDidLoad()
        self.view.wantsLayer = true
        let background = NSImage(resource: .timerBackground)
        self.view.layer!.contents = background
        
        
        timerStackView.addView(timerLabel, in: .center)
        timerStackView.distribution = .equalSpacing
        
    

        
        
        timerStackView.snp.makeConstraints{ (make) -> Void in

            make.top.equalTo(view)
            make.bottom.equalTo(view)

            make.left.equalTo(view)
            make.right.equalTo(view)

        }
        
        timerStackView.edgeInsets.bottom = 20
        timerStackView.edgeInsets.top = 20
        timerStackView.edgeInsets.left = 20
        timerStackView.edgeInsets.right = 20
        timerStackView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        timerStackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        timerStackView.setHuggingPriority(.defaultLow, for: .horizontal)
        timerStackView.setHuggingPriority(.defaultLow, for: .vertical)
        

        timerLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        timerLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        timerLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        timerLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        timerLabel.snp.makeConstraints{ (make) -> Void in
            make.center.equalTo(timerStackView)
            make.width.equalTo(450)
        }
        
        
        timerLabel.stringValue = "\(timer)"
        timerLabel.drawsBackground = true
        timerLabel.backgroundColor = .black
        
        timerLabel.isBordered = true
        
       
       
    
    }
    
    
    
    
    override func viewDidAppear() {
        super.viewDidAppear()
       
    }
    
    @IBAction func openControls(_ sender: Any?) {
        performSegue(withIdentifier: "ShowTimerContols", sender: sender)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destinationController as! TimerControlsViewController
        
        destinationVC.timer = self
        
    }
    
    

}
