//
//  ATrackerTabItemViewController.swift
//  ATracker
//
//  Created by Hector on 10/17/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Cocoa

class ATrackerTabItemViewController: NSViewController {

    @IBOutlet var startStopSegmentedControl: NSSegmentedControl!
    @IBOutlet var titleTextField: NSTextField!
    @IBOutlet var startTimeTextField: NSTextField!
    @IBOutlet var endTimeTextField: NSTextField!
    @IBOutlet var summaryScrollView: NSScrollView!
    
    @IBOutlet var confirmButton: NSButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }

    private func setupViews() {
        startStopSegmentedControl.selectedSegment = 0
        confirmButton.action = #selector(confirmButtonPressed)
    }
    
    @objc
    func confirmButtonPressed() {
        startStopSegmentedControl.selectedSegment = startStopSegmentedControl.selectedSegment == 1 ? 0 : 1
    }
    
}
