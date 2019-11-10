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
    private let eventStore: EKEventStore
    
    /// returns event calendars array
    var eventCalendars: [EKCalendar] {
        eventStore.calendars(for: .event)
    }
    
    /// returns reminder calendars array
    var reminderCalendars: [EKCalendar] {
        eventStore.calendars(for: .reminder)
    }
    
    init(eventStore: EKEventStore = EKEventStore()) {
        self.eventStore = eventStore
    }
    
    /// returns true if calendar with title exitst
    func calendarExist(with title: String) -> Bool {
        for calendar in eventCalendars {
            if calendar.title == title {
                return true
            }
        }
        
        return false
    }

    /// check permission and request access to calendar from user
    func permission() {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .denied:
            eventStore.requestAccess(to: .event) { _, _ in}
        case .notDetermined:
            eventStore.requestAccess(to: .event) { _, _ in}
        default:
            NSLog("EventKitController.permission() went to default")
            // eventStore.requestAccess(to: .event) { _, _ in}
        }
    }
    
    /// create new event calendar inside icloud default, if exist do nothing
    func createNewCalendar(with title: String, using sourceType: EKSourceType = EKSourceType.calDAV) {
        let newCalendar = EKCalendar(for: .event, eventStore: eventStore)
        newCalendar.title = title
        newCalendar.source = eventStore.sources.filter { $0.sourceType.rawValue == sourceType.rawValue}.first!
        
        do {
            try eventStore.saveCalendar(newCalendar, commit: true)
        } catch {
            NSLog("Error creating calendar: \(error)")
        }
    }
    
    /// insert event to  calendar
    func insertEvent(with calendar: EKCalendar, atrack: ATrack) {
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
