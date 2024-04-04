//
//  HomeTableViewCell.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

import UIKit
import Kingfisher

final class HomeTableViewCell: UITableViewCell {
    static let nibName = "HomeTableViewCell"
    static let identifier = "HomeTableViewCell"
    
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
    @IBOutlet private weak var roverLabel: UILabel!
    @IBOutlet private weak var cameraLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var photoImageView: ContentImageView! {
        didSet {
            photoImageView.layer.cornerRadius = 20
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.translatesAutoresizingMaskIntoConstraints = false
            photoImageView.clipsToBounds = true
            photoImageView.kf.indicatorType = .activity
        }
    }
    
    // MARK: Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        roverLabel.text = nil
        cameraLabel.text = nil
        dateLabel.text = nil
        photoImageView.image = nil
    }
    
    // MARK: Methods
    
    func refresh(with displayModel: HomeCellItem) {
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
            text: displayModel.formattedDate
        )
        photoImageView.load(imageURL: displayModel.imageStringURL, placeholder: nil)
    }
    
    func cancelDownloadTask() {
        photoImageView.kf.cancelDownloadTask()
    }
}
