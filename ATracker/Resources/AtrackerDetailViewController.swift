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
    @IBOutlet var deleteButton: NSButton!
    @IBOutlet var startTextField: NSTextField!
    @IBOutlet var endTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        deleteButton.action = #selector(deleteTrackButtonPressed)
    }
    
    
    
    @objc
    func deleteTrackButtonPressed() {
        
    }
}
