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
        
    func applicationDidFinishLaunching(_ aNotification: Notification) {
      //  Thread.callStackSymbols.forEach{print($0)}
        EventKitController().permission()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }

}

