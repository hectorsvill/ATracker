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
    case comboBox = "ComboBoxState"
    
}

class ATrackerTabItemViewController: NSViewController {
    let udStandard = UserDefaults.standard
    var eventKitController: EventKitController?
    var aTrackerController: ATrackerController?

    @IBOutlet var titleTextField: NSTextField!
    @IBOutlet var summaryTextView: NSTextView!
    @IBOutlet var startTimeTextField: NSTextField!
    @IBOutlet var endTimeTextField: NSTextField!
    @IBOutlet var startStopButton: NSButton!
    @IBOutlet var comboBox: NSComboBox!
    
    var mediumDateFormat: DateFormatter {
        let dateFormtater = DateFormatter()
        dateFormtater.dateStyle = .medium
        dateFormtater.timeStyle = .medium
        return dateFormtater
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comboBox.delegate = self
        comboBox.dataSource = self
        comboBox.completes = true
        comboBox.numberOfVisibleItems = eventKitController!.eventCalendars.count
        comboBox.selectItem(at: 0)
        
        
        
        setupViews()
        eventKitController?.permission()
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
    
        setOnViewWillDisapear()
    }
    
    private func setOnViewWillDisapear() {
        let trackTitle = titleTextField.stringValue
        let summary = summaryTextView.string
        let buttonTitle = startStopButton.title
        let comboBoxState = comboBox.indexOfSelectedItem
        
        
        udStandard.set(trackTitle, forKey: UserDefaultKeys.title.rawValue)
        udStandard.set(summary, forKey: UserDefaultKeys.summary.rawValue)
        udStandard.set(buttonTitle, forKey: UserDefaultKeys.buttonstate.rawValue)
        udStandard.set(comboBoxState, forKey: UserDefaultKeys.comboBox.rawValue)
    }
    private func setupViews() {
        titleTextField.stringValue =  udStandard.string(forKey: UserDefaultKeys.title.rawValue) ?? ""
        summaryTextView.string = udStandard.string(forKey: UserDefaultKeys.summary.rawValue) ?? ""
       
        if let start = udStandard.object(forKey: UserDefaultKeys.startDate.rawValue) as? Date {
            startTimeTextField.stringValue = "Task Started on \(mediumDateFormat.string(from: start))"
        }
        
        if let end = udStandard.object(forKey: UserDefaultKeys.endDate.rawValue) as? Date {
            
            endTimeTextField.stringValue = "Task Ended on \(mediumDateFormat.string(from: end))"
        }
        
        startStopButton.title = udStandard.string(forKey: UserDefaultKeys.buttonstate.rawValue) ?? "Start"
        startStopButton.action = #selector(startStopButtonPressed)
        
        // combobox
        let comboBoxState = udStandard.integer(forKey: UserDefaultKeys.comboBox.rawValue)
        comboBox.selectItem(at: comboBoxState)
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
 
        let atrack = ATrack(title: atrackTitle, summary: summary, start: start, end: end)
        ATrackerController().createATrack(title: atrackTitle, summary: summary, start: start, end: end)
        

        let calendar = eventKitController?.eventCalendars[comboBox.indexOfSelectedItem]
        
        eventKitController?.insertEvent(with: calendar!, atrack: atrack)
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

extension ATrackerTabItemViewController: NSComboBoxDataSource, NSComboBoxDelegate {
    
    func numberOfItems(in comboBox: NSComboBox) -> Int {
        return eventKitController?.eventCalendars.count ?? 0
    }
    
    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        return "\(eventKitController!.eventCalendars[index].title)"
    }
    
}
