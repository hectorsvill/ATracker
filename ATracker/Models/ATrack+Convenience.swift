//
//  ATrack+Convenience.swift
//  ATracker
//
//  Created by Hector on 10/20/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Foundation
import CoreData

extension ATrack {
    convenience init(title: String, summary: String? = nil, start: Date, end: Date? = nil, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.title = title
        self.summary = summary
        self.start = start
        self.end = end
    }
}
