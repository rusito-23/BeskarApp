//
//  Date+Helpers.swift
//  Beskar
//
//  Created by Igor on 27/03/2021.
//

import Foundation

extension Date {

    /// A convenience function to obtain the current date
    static func now() -> Date { Date() }

    /// A var to get the minutes between now and the date
    var minutesElapsed: Int {
        -Int(timeIntervalSinceNow / 60)
    }
}
