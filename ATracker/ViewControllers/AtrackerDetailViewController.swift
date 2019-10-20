//
//  AtrackerDetailViewController.swift
//  ATracker
//
//  Created by Hector on 10/19/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Cocoa

class AtrackerDetailViewController: NSViewController {

    @IBOutlet var titleTextField: NSTextField!
    @IBOutlet var summaryTextView: NSTextView!
    @IBOutlet var saveButton: NSButton!
    @IBOutlet var startButton: NSButton!
    @IBOutlet var stopButton: NSButton!
    @IBOutlet var startTextField: NSTextField!
    @IBOutlet var endTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
//        guard let title = titleTextField?.stringValue, let summary = summaryTextView?.string else { return }
        
        
        
        saveButton.action = #selector(saveTrackButtonPressed)
//        saveButton.isEnabled = false
        startButton.action = #selector(startTrackingButtonPressed)
        stopButton.action = #selector(stopTrackingButtonPressed)
        stopButton.isEnabled = false
        
    }
    
    @objc
    func saveTrackButtonPressed() {
        print(titleTextField.stringValue.isEmpty)
    }
    
    @objc
    func startTrackingButtonPressed() {
        // Title is empty
        guard !titleTextField.stringValue.isEmpty else { return }
        
        startButton.isEnabled.toggle()
        stopButton.isEnabled.toggle()
        startTextField.stringValue = "start: \(Date())"
        //        print(summaryTextView.textStorage?.string)
    }
    
    @objc
    func stopTrackingButtonPressed() {
        stopButton.isEnabled.toggle()
        endTextField.stringValue = "end: " + "\(Date())"
    }
    
}
