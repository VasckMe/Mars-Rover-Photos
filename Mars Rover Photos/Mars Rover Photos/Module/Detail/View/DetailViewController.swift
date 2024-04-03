//
//  DetailViewController.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 3.04.24.
//

import UIKit
import Combine

class DetailViewController: UIViewController {
    static let nibName = "DetailViewController"
    
    var viewModel: DetailViewModelProtocol?
    
    @IBOutlet private weak var zoomView: ZoomView!
    @IBOutlet private weak var closeButton: UIButton! {
        didSet {
            closeButton.titleLabel?.text = nil
        }
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel?.didTriggerViewLoad()
    }

    @IBAction func closeButtonAction(_ sender: Any) {
        zoomView.setZoomScale(0, animated: false)
        viewModel?.didTriggerClose()
    }
}

// MARK: - Private

private extension DetailViewController {
    func configure() {
        configureView()
        bind()
    }
    
    func configureView() {
        view.backgroundColor = Color.layerOne.value
    }
    
    func bind() {
        viewModel?.inputPublisher
            .sink(receiveValue: { [weak self] input in
                self?.zoomView.setImage(urlString: input.imageStringURL)
            })
            .store(in: &cancellables)
    }
}
