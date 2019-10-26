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
    @IBOutlet var summaryTextView: NSTextView!
    @IBOutlet var startTimeTextField: NSTextField!
    @IBOutlet var endTimeTextField: NSTextField!
    @IBOutlet var startStopButton: NSButton!
    
    var mediumDateFormat: DateFormatter {
        let dateFormtater = DateFormatter()
        dateFormtater.dateStyle = .medium
        dateFormtater.timeStyle = .medium
        return dateFormtater
    }
    
    
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
    
}

// MARK: startButton

extension ATrackerTabItemViewController {
    
    private func setupStartButton(with startStopButtonTitle: String) {
        startStopButton.title = startStopButtonTitle == "Start" ? "Stop" : "Start"
    }
    
    private func isStartButton() {
        let currentDate = Date()
        let formatedDate = mediumDateFormat.string(from: currentDate)
        startTimeTextField.stringValue = "Started Task: " + formatedDate
        ATrackerController().createATrack(title: titleTextField.stringValue, summary: summaryTextView.string, start: currentDate, end: nil)
    }
    
    private func isStopButton() {
        let currentDate = Date()
        let formatedDate = mediumDateFormat.string(from: currentDate)
        endTimeTextField.stringValue = "Ended Task: " + formatedDate
        startStopButton.title = "Save"
        
    }
    
    private func isSaveButton() {
        print("Save")
        startTimeTextField.stringValue = ""
        endTimeTextField.stringValue = ""
        startStopButton.title = "Start"
    
    }
    
    @objc
    func startStopButtonPressed() {
        let startStopButtonTitle = startStopButton.title
        setupStartButton(with: startStopButtonTitle)
        
        if startStopButtonTitle == "Start" {
            isStartButton()
        } else if startStopButtonTitle == "Stop" {
            isStopButton()
        } else {
            isSaveButton()
        }
    }
}


// MARK: NSTextFieldDelegate

extension ATrackerTabItemViewController: NSTextFieldDelegate {
    func textField(_ textField: NSTextField, textView: NSTextView, shouldSelectCandidateAt index: Int) -> Bool {
        print(titleTextField.stringValue)
        return true
    }
    
    func controlTextDidChange(_ obj: Notification) {
        print(titleTextField.stringValue)
//        print(summaryTextView.string)
    }
    
}
 

// MARK: NSTextViewDelegate
    
extension ATrackerTabItemViewController: NSTextViewDelegate {
    
    func textDidChange(_ notification: Notification) {
        guard let textView = notification.object as? NSTextView else { return }
        print(textView.string)
    }
    
    
}
