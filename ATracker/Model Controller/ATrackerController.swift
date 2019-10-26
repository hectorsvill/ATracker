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
//        createATrack(title: "this title", start: Date(timeIntervalSinceNow: -11000), end: Date(timeIntervalSinceNow: 10000))
//        try! CoreDataStack.shared.mainContext.save()
//
//        deleteAllATrack()
//        deleteATrack(aTrackerList[1])
    }
    
    // MARK: Computed Properties
    
    private var moc: NSManagedObjectContext{
        return CoreDataStack.shared.mainContext
    }
    
    var aTrackerList: [ATrack] {
        let fetchRequest: NSFetchRequest<ATrack> = ATrack.fetchRequest()
        
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching task: \(error)")
            return []
        }
    }
    
    func createATrack(title: String, summary: String? = nil, start: Date, end: Date? = nil) {
        _ = ATrack(title: title, summary: summary, start: start, end: end)
        try! CoreDataStack.shared.mainContext.save()
    }
    
    func deleteATrack(_ atrack: ATrack) {
        guard let firstIndex = aTrackerList.firstIndex(of: atrack) else { return }
        moc.delete(aTrackerList[firstIndex])
    }
    
    private func deleteAllATrack() {
        _ = aTrackerList.map { moc.delete($0) }
    }
}
