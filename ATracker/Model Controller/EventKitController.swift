//
//  EventController.swift
//  ATracker
//
//  Created by Hector on 10/27/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Cocoa
import EventKit

class EventKitController {
    
    let calendarTitle: String
    let eventStore: EKEventStore
    
    init(calendarTitle: String = "ATaskTracker", eventStore: EKEventStore = EKEventStore()) {
        self.calendarTitle = calendarTitle
        self.eventStore = eventStore
        
    }
    
    func permission() {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            print("Auth")
        case .denied:
            eventStore.requestAccess(to: .event) { _, _ in}
            print("access denied")
        case .notDetermined:
            eventStore.requestAccess(to: .event) { _, _ in}
            print("access denied")
        default:
            print("Access denied")
        }
    }
    
    func fetchCalendar(with title: String) -> EKCalendar {
        eventStore.calendars(for: .event).filter{ $0.title == calendarTitle }.first!
    }
    
    func insertEvent(with atrack: ATrack) {
        let calendar = fetchCalendar(with: calendarTitle)
        print(calendar)

        let event = EKEvent(eventStore: eventStore)
        event.calendar = calendar
        event.title = atrack.title
        event.notes = atrack.summary
        event.url = nil
        event.startDate = atrack.start
        event.endDate = atrack.end
                
        do {
            try eventStore.save(event, span: .thisEvent)
        } catch {
            NSLog("Error with event: \(error)")
        }
                
    }
    
    
}
