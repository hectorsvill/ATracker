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
    
    var ATrackerList: [ATrack] {
        let fetchRequest: NSFetchRequest<ATrack> = ATrack.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching task: \(error)")
            return []
        }
    }
    
    
    
    
}
