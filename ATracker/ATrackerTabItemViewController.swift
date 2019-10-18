//
//  ATrackerTabItemViewController.swift
//  ATracker
//
//  Created by Hector on 10/17/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Cocoa

class ATrackerTabItemViewController: NSViewController {

    @IBOutlet weak var trackButton: NSButton!
    
    @IBOutlet weak var aTrackerLabel: NSTextField!
    @IBOutlet weak var titleTextField: NSTextField!
    @IBOutlet weak var aTrakcerSummaryScrollView: NSScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func trackButtonPressed(_ sender: NSButton) {
        
        
        
        guard let title = titleTextField?.stringValue else {
            return
        }
        
        
        print(title)
        
    }
}
