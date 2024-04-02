//
//  UIView.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

import UIKit

extension UIView {
    func dropShadow(
        color: UIColor?,
        alpha: CGFloat,
        opacity: Float = .zero,
        offset: CGSize = .init(width: 0.0, height: -3.0),
        radius: CGFloat = 3.0
    ) {
        layer.shadowColor = color?.withAlphaComponent(alpha).cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
}
