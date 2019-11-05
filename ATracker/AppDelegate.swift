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
        print("applicationDidFinishLaunching")
        Thread.callStackSymbols.forEach{print($0)}
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        print("applicationWillTerminate")
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        
        print("applicationShouldTerminateAfterLastWindowClosed")
        return false
    }

}

