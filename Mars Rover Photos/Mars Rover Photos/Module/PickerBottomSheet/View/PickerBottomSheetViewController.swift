//
//  PickerBottomSheetViewController.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

import UIKit
import Combine

final class PickerBottomSheetViewController: UIViewController {
    var viewModel: PickerBottomSheetViewModelProtocol? {
        didSet {
            cancellables.removeAll()
            bind()
            self.viewModel?.didTriggerUpdatePublishers()
        }
    }
    
    private let shadowView: UIView = {
        let view = UIView()
        view.clipsToBounds = false
        view.layer.cornerRadius = 50
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.dropShadow(
            color: Color.layerOne.value,
            alpha: 0.1,
            opacity: 0.5,
            offset: .init(width: 0, height: -4)
        )
        view.backgroundColor = Color.backgroundOne.value
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.clipsToBounds = false
        view.layer.cornerRadius = 50
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = Color.backgroundOne.value
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "tick"), for: .normal)
        button.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title2.value
        label.text = "Item"
        return label
    }()
    
    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - UIPickerViewDataSource

extension PickerBottomSheetViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel?.numberOfItems ?? 0
    }
}

// MARK: - UIPickerViewDelegate

extension PickerBottomSheetViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = viewModel?.displayModel(at: row)
        return item?.name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel?.didTriggerSelectItem(at: row)
    }
}

// MARK: - Private

private extension PickerBottomSheetViewController {
    func configure() {
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        view.addSubview(shadowView)
        view.addSubview(contentView)
        contentView.addSubview(closeButton)
        contentView.addSubview(saveButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(pickerView)
    }
    
    func setConstraints() {
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        shadowView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
            make.height.width.equalTo(44)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
            make.height.width.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(closeButton)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualTo(closeButton.snp.trailing).inset(-20)
            make.trailing.lessThanOrEqualTo(saveButton.snp.leading).inset(-20)
        }
        
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom).inset(-20)
            make.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }
    
    func bind() {
        viewModel?.titlePublisher
            .sink(receiveValue: { [weak self] title in
                self?.titleLabel.text = title
            })
            .store(in: &cancellables)
        viewModel?.displayItemsPublisher
            .sink(receiveValue: { [weak self] _ in
                self?.pickerView.reloadAllComponents()
            })
            .store(in: &cancellables)
    }
    
    @objc func closeButtonAction() {
        viewModel?.didTriggerCloseButton()
    }
    
    @objc func saveButtonAction() {
        viewModel?.didTriggerSaveButton()
    }
}
