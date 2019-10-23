//
//  ATrackerTabItemViewController.swift
//  ATracker
//
//  Created by Hector on 10/17/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Cocoa

class ATrackerTabItemViewController: NSViewController {

    @IBOutlet var titleTextField: NSTextField!
    @IBOutlet var startTimeTextField: NSTextField!
    @IBOutlet var endTimeTextField: NSTextField!
    
    
    @IBOutlet var summaryTextView: NSTextView!
    
    @IBOutlet var startStopButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        titleTextField.delegate = self
        summaryTextView.delegate = self
//        summaryScrollView
        startStopButton.action = #selector(startStopButtonPressed)
        // set curremt time
        
    
    }
    
    @objc
    func startStopButtonPressed() {
        let startStopButtonTitle = startStopButton.title
        startStopButton.title = startStopButtonTitle == "Start" ? "Stop" : "Start"
        
        if startStopButtonTitle == "Start" {
            let currentDate = Date()
            let dateFormtater = DateFormatter()
            dateFormtater.dateStyle = .medium
            dateFormtater.timeStyle = .medium
            
            print(titleTextField.stringValue)
            
            startTimeTextField.stringValue = "Started Task: " + dateFormtater.string(from: currentDate)
        } else if startStopButtonTitle == "Stop" {
            let currentDate = Date()
            let dateFormtater = DateFormatter()
            dateFormtater.dateStyle = .medium
            dateFormtater.timeStyle = .medium
            
            
            
            endTimeTextField.stringValue = "Ended Task: " + dateFormtater.string(from: currentDate)
            startStopButton.title = "Save"
        } else {
            print("Save")
            startTimeTextField.stringValue = ""
            endTimeTextField.stringValue = ""
            startStopButton.title = "Start"
        }
    }
}


extension ATrackerTabItemViewController: NSTextFieldDelegate, NSTextViewDelegate {
    
    func textField(_ textField: NSTextField, textView: NSTextView, shouldSelectCandidateAt index: Int) -> Bool {
        
        print(titleTextField.stringValue)
        return true
    }
    
//    func control(_ control: NSControl, textShouldBeginEditing fieldEditor: NSText) -> Bool {
//        print("textShouldBeginEditing")
//        return true
//    }
//
//    func control(_ control: NSControl, textShouldEndEditing fieldEditor: NSText) -> Bool {
//        print("textShouldEndEditing")
//        return  true
//    }
//
    func controlTextDidChange(_ obj: Notification) {
        print(titleTextField.stringValue)
        
//        print(summaryTextView.string)
    }
    
    func textDidChange(_ notification: Notification) {
        guard let textView = notification.object as? NSTextView else { return }
        print(textView.string)
    }
    
    
}
