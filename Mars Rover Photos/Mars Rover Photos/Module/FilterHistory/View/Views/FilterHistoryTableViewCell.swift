//
//  FilterHistoryTableViewCell.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

import UIKit

final class FilterHistoryTableViewCell: UITableViewCell {
    static let nibName = "FilterHistoryTableViewCell"
    static let identifier = "FilterHistoryTableViewCell"
    
    @IBOutlet private weak var shadowView: UIView! {
        didSet {
            shadowView.layer.cornerRadius = 30
            shadowView.dropShadow(
                color: Color.layerOne.value,
                alpha: 0.08,
                opacity: 0.5,
                offset: .init(width: 0, height: 3)
            )
        }
    }
    @IBOutlet private weak var cardView: UIView! {
        didSet {
            cardView.layer.cornerRadius = 30
        }
    }
    @IBOutlet private weak var filterLabel: UILabel! {
        didSet {
            filterLabel.font = Font.title2.value
            filterLabel.text = "Filter"
            filterLabel.textColor = Color.accentOne.value
        }
    }
    @IBOutlet private weak var filterSeparatorView: UIView!
    @IBOutlet private weak var roverLabel: UILabel!
    @IBOutlet private weak var cameraLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Methods
    
    func refresh(with displayModel: FilterDisplayItem) {
        roverLabel.attributedText = HelperUtilities.makeAttributedString(
            text: "Rover: ",
            text: displayModel.rover
        )
        cameraLabel.attributedText = HelperUtilities.makeAttributedString(
            text: "Camera: ",
            text: displayModel.camera
        )
        dateLabel.attributedText = HelperUtilities.makeAttributedString(
            text: "Date: ",
            text: displayModel.dateString
        )
    }
}
