//
//  Color.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

import UIKit

enum Color: String {
    case backgroundOne
    case accentOne
    case layerOne
    case layerTwo
    case systemTwo
    case systemThree
    
    case clear
    
    var value: UIColor? {
        return UIColor(named: self.rawValue)
    }
    
    var cgValue: CGColor? {
        return value?.cgColor
    }
}
