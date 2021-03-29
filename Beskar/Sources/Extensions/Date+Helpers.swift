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

    /// Check minutes elapsed since date
    func elapsed(minutes: Int) -> Bool {
        -Int(timeIntervalSinceNow / 60) > minutes
    }
}
