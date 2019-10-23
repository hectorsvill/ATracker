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
    @IBOutlet var summaryScrollView: NSScrollView!
    @IBOutlet var startStopButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        startStopButton.action = #selector(startStopButtonPressed)
        // set curremt time
    
    }
    
    @objc
    func startStopButtonPressed() {
        startStopButton.title = startStopButton.title == "Start" ? "Stop" : "Start"
        
        
    }
}
