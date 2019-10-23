//
//  ATrackerController.swift
//  ATracker
//
//  Created by Hector on 10/20/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Foundation
import CoreData

class ATrackerController {
    
    init() {
//        createATrack(title: "this title", start: Date(timeIntervalSinceNow: -11000), end: Date())
//        try! CoreDataStack.shared.mainContext.save()
    }
    
    var aTrackerList: [ATrack] {
        let fetchRequest: NSFetchRequest<ATrack> = ATrack.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching task: \(error)")
            return []
        }
    }
    
    
    func createATrack(title: String, summary: String? = nil, start: Date, end: Date) {
        let _ = ATrack(title: title, summary: summary, start: start, end: end)
    }
    
    
    private func deleteAllATrack() {
        let moc = CoreDataStack.shared.mainContext
        
        
        
        for aTracker in aTrackerList {
            moc.delete(aTracker)
        }
    }
    
    
}
