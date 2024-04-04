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
    
    static func makeAttributedString(text first: String, text second: String) -> NSMutableAttributedString {
        let attributes1: [NSAttributedString.Key: Any] = [
            .font: Font.body.value,
            .foregroundColor: Color.layerTwo.value
        ]
        let attributedString1 = NSAttributedString(string: first, attributes: attributes1)

        let attributes2: [NSAttributedString.Key: Any] = [
            .font: Font.body2.value,
            .foregroundColor: Color.layerOne.value
        ]
        let attributedString2 = NSAttributedString(string: second, attributes: attributes2)
        
        let fullAttributedString = NSMutableAttributedString()
        fullAttributedString.append(attributedString1)
        fullAttributedString.append(attributedString2)
        
        return fullAttributedString
    }
}
