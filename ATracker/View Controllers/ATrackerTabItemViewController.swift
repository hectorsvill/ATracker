//
//  ATrackerTabItemViewController.swift
//  ATracker
//
//  Created by Hector on 10/17/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Cocoa

enum UserDefaultKeys: String {
    case title = "title"
    case summary = "summary"
    case startDateString = "startDateString"
    case endDateString = "endDateString"
    case buttonstate = "buttonState"
}



class ATrackerTabItemViewController: NSViewController {
    
    var aTrackerController: ATrackerController?

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
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        
        let title = titleTextField.stringValue
        let summary = summaryTextView.string
        let dateString = startTimeTextField.stringValue
        let endDateString = endTimeTextField.stringValue
        let buttonTitle = startStopButton.title
        
        UserDefaults.standard.set(title, forKey: UserDefaultKeys.title.rawValue)
        UserDefaults.standard.set(summary, forKey: UserDefaultKeys.summary.rawValue)
        UserDefaults.standard.set(dateString, forKey: UserDefaultKeys.startDateString.rawValue)
        UserDefaults.standard.set(endDateString, forKey: UserDefaultKeys.endDateString.rawValue)
        UserDefaults.standard.set(buttonTitle, forKey: UserDefaultKeys.buttonstate.rawValue)
    }
    
    private func setupViews() {
        titleTextField.stringValue = UserDefaults.standard.string(forKey: UserDefaultKeys.title.rawValue) ?? ""
        summaryTextView.string = UserDefaults.standard.string(forKey: UserDefaultKeys.summary.rawValue) ?? ""
        startTimeTextField.stringValue = UserDefaults.standard.string(forKey: UserDefaultKeys.startDateString.rawValue) ?? ""
        endTimeTextField.stringValue = UserDefaults.standard.string(forKey: UserDefaultKeys.endDateString.rawValue) ?? ""
        startStopButton.title = UserDefaults.standard.string(forKey: UserDefaultKeys.buttonstate.rawValue) ?? "Start"
        startStopButton.action = #selector(startStopButtonPressed)
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
        endTimeTextField.stringValue = "Task in progress... "
        ATrackerController().createATrack(title: titleTextField.stringValue, summary: summaryTextView.string, start: currentDate, end: nil)
    
    }
    
    private func isStopButton() {
        let currentDate = Date()
        let formatedDate = mediumDateFormat.string(from: currentDate)
        endTimeTextField.stringValue = "Ended Task: " + formatedDate
        startStopButton.title = "Save"
        
    }
    
    private func isSaveButton() {
        titleTextField.stringValue = ""
        summaryTextView.string = ""
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
