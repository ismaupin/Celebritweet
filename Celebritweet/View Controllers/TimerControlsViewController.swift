//
//  TimerControlsViewController.swift
//  Celebritweet
//
//  Created by Isaac Maupin on 8/11/20.
//  Copyright © 2020 Isaac Maupin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TimerControlsViewController: NSViewController, NSTextFieldDelegate {
    
    //MARK: Properties -
    
    @IBOutlet var startButton: NSButton!
    @IBOutlet var stopButton: NSButton!
    @IBOutlet var resetButton: NSButton!
    @IBOutlet var setTimeTextField: NSTextField!
    
    var timer: TimerViewController?
    let disposeBag = DisposeBag()
    var appTimer: Timer?
    
    let timerAmountRelay = BehaviorRelay<Double>(value: 0.00)
    
    //MARK: Methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.isEnabled = false
        stopButton.isEnabled = false
        resetButton.isEnabled = false
        setTimeTextField.delegate = self
        
        timerAmountRelay
            .subscribe(
                onNext:{ self.timer?.timerLabel.stringValue = String(format: "%.1f", $0)
            })
            .disposed(by: disposeBag)
    }
    
    func controlTextDidChange(_ obj: Notification) {
        guard let double = Double(setTimeTextField.stringValue) else{ return }
        timer?.timerLabel.textColor = double > 5 ? .white : .red
        timerAmountRelay.accept(double)
        startButton.isEnabled = true
    }
    
    @objc func timerFired() {
        timerAmountRelay.accept(timerAmountRelay.value - 0.1)
        
        timer?.timerLabel.textColor = timerAmountRelay.value <= 5 ? .red : .white
        
        if timerAmountRelay.value < 0.1 {
            self.appTimer!.invalidate()
            self.timer?.timerLabel.stringValue = "0.0"
            startButton.isEnabled = false
            stopButton.isEnabled = false
        }
    }
    
    @IBAction func startButtonClicked(_ sender: NSButton) {
        
        appTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        RunLoop.main.add(appTimer!, forMode: .common)
        
        startButton.isEnabled = false
        stopButton.isEnabled = true
        resetButton.isEnabled = true
    }
    
    @IBAction func stopButtonClicked(_ sender: NSButton) {
        //pause the timer (you should be able to start back at this time
        appTimer?.invalidate()
        startButton.isEnabled = true
    }
    
    @IBAction func resetButtonClicked(_ sender: Any) {
        guard let double = Double(setTimeTextField.stringValue) else {return}
        // reset timer to time in textbox
        startButton.isEnabled = appTimer!.isValid ? false : true
        timerAmountRelay.accept(double)
        self.timer?.timerLabel.textColor = .white
    }
}
