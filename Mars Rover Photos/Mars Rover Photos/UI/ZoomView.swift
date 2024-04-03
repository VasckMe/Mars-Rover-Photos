//
//  ZoomView.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 3.04.24.
//

import UIKit

class ZoomView: UIScrollView {

    private let imageView: ContentImageView = {
        let imageView = ContentImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func setImage(urlString: String) {
        imageView.load(imageURL: urlString, placeholder: nil)
    }
}

// MARK: - UIScrollViewDelegate

extension ZoomView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

// MARK: - Private

private extension ZoomView {
    func configure() {
        addSubivews()
        setConstraints()
        configureScrollView()
    }
    
    func addSubivews() {
        addSubview(imageView)

    }
    
    func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.width.height.centerY.centerX.equalToSuperview()
        }
    }
    
    func configureScrollView() {
        minimumZoomScale = 1
        maximumZoomScale = 3
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        delegate = self
    }
}
