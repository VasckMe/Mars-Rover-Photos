//
//  PreloaderViewController.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

import UIKit
import Lottie
import SnapKit

final class PreloaderViewController: UIViewController {
    private let squareView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.accentOne.value
        view.layer.cornerRadius = 30
        view.clipsToBounds = false
        view.layer.borderColor = Color.layerOne.cgValue
        view.layer.borderWidth = 1
        view.dropShadow(
            color: Color.layerOne.value,
            alpha: 0.1,
            opacity: 0.55,
            offset: .init(width: 0, height: 20)
        )
        return view
    }()
    
    private let animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "loader")
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.contentMode = .scaleAspectFit
        return animationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        configureView()
        configureAnimation()
    }
}

// MARK: - Private

private extension PreloaderViewController {
    func addSubviews() {
        view.addSubview(squareView)
        view.addSubview(animationView)
    }
    
    func setConstraints() {
        squareView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(123)
        }

        animationView.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualToSuperview().inset(20)
            make.trailing.lessThanOrEqualToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.top.greaterThanOrEqualTo(squareView.snp.bottom)
            make.bottom.equalTo(view.layoutMarginsGuide).inset(50)
        }
    }
    
    func configureView() {
        view.backgroundColor = Color.backgroundOne.value
    }
    
    func configureAnimation() {
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 0.5
          
        animationView.play {completed in
            self.hideController(self)
        }
    }
}
