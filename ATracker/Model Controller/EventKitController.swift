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
    
    var calendarTitle: String
    let eventStore: EKEventStore
    
    
    init(calendarTitle: String = "TaskTrackerApp", eventStore: EKEventStore = EKEventStore()) {
        self.calendarTitle = calendarTitle
        self.eventStore = eventStore
    }
    
    // returns event calendar dict
    var eventCalendars: [EKCalendar] {
        eventStore.calendars(for: .event)
    }
    
    // returns true if calendar exist
    var calendarExist: EKCalendar? {
        
        for calendar in eventCalendars {
            if calendar.title == self.calendarTitle {
                return calendar
            }
        }

        return nil
    }

    // check permission and request access to calendar from user
    func permission() {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .denied:
            eventStore.requestAccess(to: .event) { _, _ in}
        case .notDetermined:
            eventStore.requestAccess(to: .event) { _, _ in}
        default:
            NSLog("EventKitController.permission() went to default")
            eventStore.requestAccess(to: .event) { _, _ in}
        }
    }
    
    // create calendar inside icloud default
    func createNewCalendar(using sourceType: EKSourceType = EKSourceType.calDAV) {
        let newCalendar = EKCalendar(for: .event, eventStore: eventStore)
        newCalendar.title = calendarTitle
        newCalendar.source = eventStore.sources.filter { $0.sourceType.rawValue == sourceType.rawValue}.first!
        newCalendar.color = .black
        
        do {
            try eventStore.saveCalendar(newCalendar, commit: true)
        } catch {
            NSLog("Error creating calendar: \(error)")
        }
    }
    
    func insertEvent(with atrack: ATrack) {
        if calendarExist != nil{
            createNewCalendar()
        }
        
        let calendar = calendarExist!


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
