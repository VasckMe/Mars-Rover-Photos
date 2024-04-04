//
//  HelperUtilities.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 3.04.24.
//

import Foundation

struct HelperUtilities {
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        return formatter
    }
    
    static func dateFormat(_ date: Date, to format: DateFormat) -> String {
        let formatter = HelperUtilities.dateFormatter
        formatter.dateFormat = format.rawValue
        let dateString = formatter.string(from: date)
        return dateString
    }
}
