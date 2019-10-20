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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViews()
    }
    
    private func setupViews() {
//        guard let title = titleTextField?.stringValue, let summary = summaryTextView?.string else { return }
        
        saveButton.action = #selector(saveTrackButtonPressed)
        startButton.action = #selector(startTrackingButtonPressed)
        stopButton.action = #selector(stopTrackingButtonPressed)
    }
    
    @objc
    func saveTrackButtonPressed() {
        print(titleTextField.stringValue.isEmpty)
    }
    
    @objc
    func stopTrackingButtonPressed() {
        print(summaryTextView.string)
    }
    
    @objc
    func startTrackingButtonPressed() {
        print("here")
    }
}
