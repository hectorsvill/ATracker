//
//  CreateCalendarViewController.swift
//  ATracker
//
//  Created by Hector on 11/3/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Cocoa

class CreateCalendarViewController: NSViewController {

    @IBOutlet weak var infoButton: NSButton!
    @IBOutlet var calendarTitleTextField: NSTextField!
    @IBOutlet var segmentControl: NSSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoButton.isHidden = true
    }
    
    @IBAction func createCalendarButtonPressed(_ sender: Any) {
        guard !calendarTitleTextField.stringValue.isEmpty else { return }
        
        if EventKitController().calendarExist(with: calendarTitleTextField.stringValue) {
            // Calendar exist error
            return
        }
        
        let selectedSegement = segmentControl.selectedSegment
        selectedSegement == 1 ? createOnIcloud() : createlocal()

        calendarTitleTextField.stringValue = ""
    }
    
    private func createOnIcloud() {
        EventKitController().createNewCalendar(with: calendarTitleTextField.stringValue)
    }
    
    private func createlocal() {
        EventKitController().createNewCalendar(with: calendarTitleTextField.stringValue, using: .local)
    }
    
}
