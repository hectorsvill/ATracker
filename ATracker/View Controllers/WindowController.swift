//
//  WindowController.swift
//  ATracker
//
//  Created by Hector on 11/3/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    let eventKitController = EventKitController()
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let aTrackerController = ATrackerController()
    
    
    override func windowDidLoad() {
        super.windowDidLoad()
        setupStatusItem()
        eventKitController.permission()
    }

}

extension WindowController {
    
    private func setupStatusItem() {
        
        statusItem.button?.title = "⏱"
        statusItem.button?.target = self
        statusItem.button?.action = #selector(trackIt)
    }
    
    @objc
    func trackIt() {
        let storyboad = NSStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboad.instantiateController(withIdentifier: "ATrackerItemBar") as? ATrackerTabItemViewController else {
            fatalError("Error getting status button item")
        }
        vc.aTrackerController = aTrackerController
        vc.eventKitController = eventKitController
        
        let popoverView = NSPopover()
        popoverView.contentViewController = vc
        popoverView.behavior = .transient
           
        guard let button = statusItem.button else {
            fatalError("Couldnt find status item button")
        }
           
        popoverView.show(relativeTo: button.bounds, of: button, preferredEdge: .maxX)
    }
}
