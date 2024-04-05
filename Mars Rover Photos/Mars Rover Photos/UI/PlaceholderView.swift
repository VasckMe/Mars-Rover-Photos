//
//  PlaceholderView.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

import UIKit

final class PlaceholderView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "error")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.layerTwo.value
        label.font = Font.body.value
        label.contentMode = .scaleAspectFit
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(title: String?) {
        titleLabel.text = title
    }
    
    func set(image: UIImage?) {
        imageView.image = image
    }
}

// MARK: - Private

private extension PlaceholderView {
    func configure() {
        addSubview(imageView)
        addSubview(titleLabel)
        
        imageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).inset(-20)
            make.centerX.equalTo(imageView)
        }
    }
}
