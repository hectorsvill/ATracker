//
//  ATrackerUnitTests.swift
//  ATrackerUnitTests
//
//  Created by Hector on 11/10/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import XCTest

class ATrackerUnitTests: XCTestCase {

   @testable import ATracker


   class ATrackerUnitTests: XCTestCase {

       let eventKitController = EventKitController()
       
       func testCreateCalendar() {
           let calendarTitle = "Test this Calendar"
           eventKitController.createNewCalendar(with: calendarTitle, using: .local)
           
           let calendarTitles = eventKitController.eventCalendars.map { $0.title }
           XCTAssertTrue(calendarTitles.contains(calendarTitle))
       }

   }


}
