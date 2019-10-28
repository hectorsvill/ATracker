//
//  EventController.swift
//  ATracker
//
//  Created by Hector on 10/27/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Foundation
import EventKit

class EventKitController {
    let eventStore = EKEventStore()
    
    init() {
        switch EKEventStore.authorizationStatus(for: .event) {
            case .authorized:
                print("Auth")
            case .denied:
                print("access denied")
            case .notDetermined:
                eventStore.requestAccess(to: .event) { _, _ in}
            default:
                print("Access denied")
        }
    }
    
    
    
    
}
