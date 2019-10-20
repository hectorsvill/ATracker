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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        print("here")
    }
    
    @IBAction func stopTrackingButtonPressed(_ sender: Any) {
        print("here")
    }
    
    @IBAction func startTrackingButtonPressed(_ sender: Any) {
        print("here")
    }
}
