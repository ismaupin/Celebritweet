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
    
    @IBOutlet var startButton: NSButton!
    @IBOutlet var stopButton: NSButton!
    @IBOutlet var resetButton: NSButton!
    
    
    var timer: TimerViewController?
    let disposeBag = DisposeBag()
    var appTimer: Timer?
    
    @IBOutlet var setTimeTextField: NSTextField!
    

    
    let timerAmountSubject = BehaviorRelay<Double>(value: 0.00)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButton.isEnabled = false
        resetButton.isEnabled = false
        setTimeTextField.delegate = self
        
        
        
        timerAmountSubject.subscribe(
        
            onNext:{ self.timer?.timerLabel.stringValue = String(format: "%.1f", $0);

        }
        ).disposed(by: disposeBag)
        
    }
    
    func controlTextDidChange(_ obj: Notification) {
        guard let double = Double(setTimeTextField.stringValue) else{ return }
        
        timerAmountSubject.accept(double)
        
    }
    
    
    @objc func timerFired() {
        timerAmountSubject.accept(timerAmountSubject.value - 0.1)
        if timerAmountSubject.value <= 5 {
            self.timer?.timerLabel.textColor = .red
        } else {
            self.timer?.timerLabel.textColor = .white
        }
        if timerAmountSubject.value < 0.1 {
            
            self.appTimer!.invalidate()
        }
    }
    
    @IBAction func startButtonClicked(_ sender: NSButton) {
        
        // write timer logic here
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
        timerAmountSubject.accept(double)
        self.timer?.timerLabel.textColor = .white
    }
}
