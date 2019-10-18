//
//  AppDelegate.swift
//  ATracker
//
//  Created by Hector on 10/16/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupStatusItem()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    
    private func setupStatusItem() {
        statusItem.button?.title = "ATracker"
        statusItem.button?.target = self
        statusItem.button?.action = #selector(trackIt)
    }
    
    @objc
    func trackIt() {
        let storyboad = NSStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboad.instantiateController(withIdentifier: "ATrackerItemBar") as? ATrackerTabItemViewController else {
            fatalError("Error getting status button item")
        }
        
        let popoverView = NSPopover()
        popoverView.contentViewController = vc
        popoverView.behavior = .transient
        
        guard let button = statusItem.button else {
            fatalError("Couldnt find status item button")
        }
        
        popoverView.show(relativeTo: button.bounds, of: button, preferredEdge: .maxX)
    }

}

