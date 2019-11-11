//
//  ATrackerUnitTests.swift
//  ATrackerUnitTests
//
//  Created by Hector on 11/10/19.
//  Copyright © 2019 Hector. All rights reserved.
//

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
        
        
        
        
    }
    
    
}
