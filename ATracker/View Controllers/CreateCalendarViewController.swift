//
//  CreateCalendarViewController.swift
//  ATracker
//
//  Created by Hector on 11/3/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Cocoa

class CreateCalendarViewController: NSViewController {

    @IBOutlet var calendarTitleTextField: NSTextField!
    @IBOutlet var segmentControl: NSSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createCalendarButtonPressed(_ sender: Any) {
        guard !calendarTitleTextField.stringValue.isEmpty else { return }
        
        let selectedSegement = segmentControl.selectedSegment
        
        
        selectedSegement == 1 ?
            EventKitController().createNewCalendar(with: calendarTitleTextField.stringValue) :
            EventKitController().createNewCalendar(with: calendarTitleTextField.stringValue, using: .local)
        
        
        calendarTitleTextField.stringValue = ""
    }
}
