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
        
        statusItem.button?.title = "ATracker"
        statusItem.button?.target = self
        
        statusItem.button?.action = #selector(trackIt)
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    
    @objc
    func trackIt() {
        
    }

}

