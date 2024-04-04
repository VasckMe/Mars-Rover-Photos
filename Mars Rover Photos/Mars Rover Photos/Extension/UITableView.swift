//
//  UITableView.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

import UIKit

extension UITableView {
    func setNoDataPlaceholder(_ message: String) {
        let placeholderView = PlaceholderView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: bounds.size.width,
                height: bounds.size.height
            )
        )
        placeholderView.set(title: message)
        self.backgroundView = placeholderView
    }
    
    func removeNoDataPlaceholder() {
        self.backgroundView = nil
    }
}
