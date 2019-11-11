//
//  ATrackerUnitTests.swift
//  ATrackerUnitTests
//
//  Created by Hector on 11/10/19.
//  Copyright ©2019 Hector. All rights reserved.
//

import EventKit
import XCTest
@testable import ATracker


class ATrackerUnitTests: XCTestCase {
    let eventKitController = EventKitController()
    let calendarTitle = "Test this Calendar"
    
    func testCreateCalendar() {
        eventKitController.createNewCalendar(with: calendarTitle, using: .local)
        let calendarTitles = eventKitController.eventCalendars.map { $0.title }
        XCTAssertTrue(calendarTitles.contains(calendarTitle))
    }
    
    func testFetchCalendar() {
        let calendar = eventKitController.fetchCalendar(with: calendarTitle)
        XCTAssertNotNil(calendar)
    }
    

    func testInsertEvent() {
        guard let calendar = eventKitController.fetchCalendar(with: calendarTitle) else {
            XCTFail()
            return
        }
        let store = eventKitController.eventStore
        
        // 20 minute event
        
        let aweekAgoStart = Date(timeIntervalSinceNow: 2400)
        let aweekAgoend = aweekAgoStart.addingTimeInterval(1200)
        
        let event = EKEvent(eventStore: store)
        event.calendar = calendar
        event.title = "Test title"
        event.notes = "notes anout the event here!"
        event.url = nil
        event.startDate = aweekAgoStart
        event.endDate = aweekAgoend
        
        try! store.save(event, span: .thisEvent)
        
    }
    
    
}
