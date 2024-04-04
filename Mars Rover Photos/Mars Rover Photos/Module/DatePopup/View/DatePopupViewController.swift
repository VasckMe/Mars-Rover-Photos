//
//  DatePopupViewController.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 3.04.24.
//

import UIKit

final class DatePopupViewController: UIViewController {
    static let nibName = "DatePopupViewController"
    
    var viewModel: DatePopupViewModelProtocol?
    
    @IBOutlet private weak var shadowView: UIView! {
        didSet {
            shadowView.backgroundColor = Color.layerOne.value?.withAlphaComponent(0.5)
        }
    }
    @IBOutlet private weak var contentView: UIView! {
        didSet {
            contentView.dropShadow(
                color: Color.layerOne.value,
                alpha: 0.08,
                opacity: 0.16,
                offset: .init(width: 0, height: 3)
            )
            contentView.layer.cornerRadius = 50
            contentView.clipsToBounds = false
        }
    }
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "Date"
            titleLabel.font = Font.title2.value
        }
    }
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var applyButton: UIButton!
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - DatePopupViewControllerProtocol

extension DatePopupViewController: DatePopupViewControllerProtocol {
    func show() {
        UIView.animate(withDuration: 0.3) {
            self.shadowView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    func hide(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0.3) {
            self.shadowView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            completion()
        }
    }
}

// MARK: - Private

private extension DatePopupViewController {
    @IBAction func closeButtonAction(_ sender: UIButton) {
        hide() { [weak self] in
            self?.viewModel?.didTriggerCloseButton()
        }
    }
    
    @IBAction func applyButtonAction(_ sender: UIButton) {
        hide() { [weak self] in
            self?.viewModel?.didTriggerSaveButton()
        }
    }
    
    @IBAction func pickerAction(_ sender: UIDatePicker) {
        viewModel?.didTriggerDatePicker(date: sender.date)
    }
    
    func configure() {
        view.backgroundColor = .clear
        shadowView.alpha = 0
        contentView.alpha = 0
    }
}
