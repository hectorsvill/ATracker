//
//  ATrackerTabItemViewController.swift
//  ATracker
//
//  Created by Hector on 10/17/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Cocoa

private enum UserDefaultKeys: String {
    case title = "title"
    case summary = "summary"
    case startDate = "startDateString"
    case endDate = "endDateString"
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
        
        let trackTitle = titleTextField.stringValue
        let summary = summaryTextView.string
        let buttonTitle = startStopButton.title
        
        UserDefaults.standard.set(trackTitle, forKey: UserDefaultKeys.title.rawValue)
        UserDefaults.standard.set(summary, forKey: UserDefaultKeys.summary.rawValue)
        UserDefaults.standard.set(buttonTitle, forKey: UserDefaultKeys.buttonstate.rawValue)
    }
    
    private func setupViews() {
        titleTextField.stringValue =  UserDefaults.standard.string(forKey: UserDefaultKeys.title.rawValue) ?? ""
        summaryTextView.string = UserDefaults.standard.string(forKey: UserDefaultKeys.summary.rawValue) ?? ""
        if let start = UserDefaults.standard.object(forKey: UserDefaultKeys.startDate.rawValue) as? Date {
            startTimeTextField.stringValue = "Task Started on \(mediumDateFormat.string(from: start))"
        }
        
        if let end = UserDefaults.standard.object(forKey: UserDefaultKeys.endDate.rawValue) as? Date {
            
            endTimeTextField.stringValue = "Task Ended on \(mediumDateFormat.string(from: end))"
        }
        
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
        UserDefaults.standard.set(currentDate, forKey: UserDefaultKeys.startDate.rawValue)
        let formatedDate = mediumDateFormat.string(from: currentDate)
        startTimeTextField.stringValue = "Started Task on " + formatedDate
        endTimeTextField.stringValue = "Task in progress... "
        ATrackerController().createATrack(title: titleTextField.stringValue, summary: summaryTextView.string, start: currentDate, end: nil)
    
    }
    
    private func isStopButton() {
        let currentDate = Date()
        UserDefaults.standard.set(currentDate, forKey: UserDefaultKeys.endDate.rawValue)
        let formatedDate = mediumDateFormat.string(from: currentDate)
        endTimeTextField.stringValue = "Ended Task on " + formatedDate
        startStopButton.title = "Save"
        
    }
    
    private func isSaveButton() {
        guard let start = UserDefaults.standard.object(forKey: UserDefaultKeys.startDate.rawValue) as? Date,
            let end = UserDefaults.standard.object(forKey: UserDefaultKeys.endDate.rawValue) as? Date else { return }
            
        let atrackTitle = titleTextField.stringValue
        let summary = summaryTextView.string
 
        ATrackerController().createATrack(title: atrackTitle, summary: summary, start: start, end: end)
        
        resetAllViewsAndDateKeys()
    }

    private func resetAllViewsAndDateKeys() {
        titleTextField.stringValue = ""
        summaryTextView.string = ""
        startTimeTextField.stringValue = ""
        endTimeTextField.stringValue = ""
        startStopButton.title = "Start"
        UserDefaults.standard.set(nil, forKey: UserDefaultKeys.startDate.rawValue)
        UserDefaults.standard.set(nil, forKey: UserDefaultKeys.endDate.rawValue)
        UserDefaults.standard.set(nil, forKey: UserDefaultKeys.title.rawValue)
        UserDefaults.standard.set(nil, forKey: UserDefaultKeys.summary.rawValue)
        UserDefaults.standard.set(nil, forKey: UserDefaultKeys.buttonstate.rawValue)
    }
    
    @objc
    func startStopButtonPressed() {
        if titleTextField.stringValue.isEmpty {
            return
        }
        
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
