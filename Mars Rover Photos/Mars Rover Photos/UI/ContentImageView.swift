//
//  ContentImageView.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 3.04.24.
//

import Kingfisher
import UIKit

final class ContentImageView: UIImageView {
    func load(
        imageURL: String,
        lowResolutionURL: String? = nil,
        placeholder: UIImage?,
        completion: (() -> Void)? = nil
    ) {
        let url = URL(string: imageURL)

        var options: KingfisherOptionsInfo = [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(0.5)),
            .cacheOriginalImage
        ]

        if
            let lowResolutionURL = lowResolutionURL,
            let lowURL = URL(string: lowResolutionURL)
        {
            options.append(.lowDataMode(.network(lowURL)))
        }

        kf.setImage(
            with: url,
            placeholder: placeholder,
            options: options,
            progressBlock: nil
        ) { _ in completion?() }
    }
}
