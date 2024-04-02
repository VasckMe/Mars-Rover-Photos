//
//  Font.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

import UIKit

enum Font {
    case largeTitle
    case title2
    case title
    case body2
    case body
    
    var value: UIFont? {
        switch self {
        case .largeTitle:
            return UIFont(name: "SFPro-Bold", size: 34)
        case .title2:
            return UIFont(name: "SFPro-Bold", size: 22)
        case .title:
            return UIFont(name: "SF Pro", size: 22)
        case .body2:
            return UIFont(name: "SFPro-Bold", size: 17)
        case .body:
            return UIFont(name: "SF Pro", size: 16)
        }
    }
}
