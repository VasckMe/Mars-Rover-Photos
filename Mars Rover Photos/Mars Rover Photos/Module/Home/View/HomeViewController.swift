//
//  HomeViewController.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

import UIKit
import Combine
import SnapKit

final class HomeViewController: UIViewController {

    var viewModel: HomeViewModelProtocol?
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.accentOne.value
        view.dropShadow(
            color: Color.layerOne.value,
            alpha: 0.12,
            opacity: 0.12,
            offset: .init(width: 0, height: 5)
        )
        view.clipsToBounds = false
        return view
    }()
    
    private let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "MARS.CAMERA"
        label.textColor = Color.layerOne.value
        label.font = Font.largeTitle.value
        return label
    }()
    
    private let headerSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body2.value
        label.textColor = Color.layerOne.value
        return label
    }()
    
    private lazy var dateButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "calendar"), for: .normal)
        button.addTarget(self, action: #selector(dateButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var roverButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "rover"), for: .normal)
        button.titleLabel?.font = Font.body2.value
        button.contentEdgeInsets = UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(Color.layerOne.value, for: .normal)
        button.backgroundColor = Color.backgroundOne.value
        button.layer.cornerRadius = 10
        button.dropShadow(
            color: Color.layerOne.value,
            alpha: 0.1,
            opacity: 0.1,
            offset: .init(width: 0, height: 4)
        )
        button.clipsToBounds = false
        button.addTarget(self, action: #selector(roverButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var cameraButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "camera"), for: .normal)
        button.titleLabel?.font = Font.body2.value
        button.contentEdgeInsets = UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(Color.layerOne.value, for: .normal)
        button.backgroundColor = Color.backgroundOne.value
        button.layer.cornerRadius = 10
        button.dropShadow(
            color: Color.layerOne.value,
            alpha: 0.1,
            opacity: 0.1,
            offset: .init(width: 0, height: 4)
        )
        button.clipsToBounds = false
        button.addTarget(self, action: #selector(cameraButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let stack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = Color.clear.value
        stackView.spacing = 0
        return stackView
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add"), for: .normal)
        button.backgroundColor = Color.backgroundOne.value
        button.layer.cornerRadius = 10
        button.dropShadow(
            color: Color.layerOne.value,
            alpha: 0.1,
            opacity: 0.1,
            offset: .init(width: 0, height: 4)
        )
        button.clipsToBounds = false
        button.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let tableViewPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "MARS.CAMERA"
        label.textColor = Color.layerTwo.value
        label.font = Font.body.value
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Color.backgroundOne.value
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(nibName: HomeTableViewCell.nibName, bundle: nil),
            forCellReuseIdentifier: HomeTableViewCell.identifier
        )
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        tableView.rowHeight = 162
        tableView.estimatedRowHeight = 162
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var historyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "history"), for: .normal)
        button.backgroundColor = Color.accentOne.value
        button.layer.cornerRadius = 35
        button.dropShadow(
            color: Color.layerOne.value,
            alpha: 0.2,
            opacity: 0.1,
            offset: .init(width: 0, height: 2)
        )
        button.clipsToBounds = false
        button.addTarget(self, action: #selector(historyButtonAction), for: .touchUpInside)
        return button
    }()
    
    private var bottomActivityIndicatorView: UIActivityIndicatorView = {
        let bottomIndicatorView = UIActivityIndicatorView(style: .medium)
        bottomIndicatorView.hidesWhenStopped = true
        bottomIndicatorView.color = Color.accentOne.value
        return bottomIndicatorView
    }()
    
    private var centerActivityIndicatorView: UIActivityIndicatorView = {
        let bottomIndicatorView = UIActivityIndicatorView(style: .medium)
        bottomIndicatorView.hidesWhenStopped = true
        bottomIndicatorView.color = Color.accentOne.value
        return bottomIndicatorView
    }()

    private var pickerSheetView: PickerBottomSheetViewController?
    private var fakeLaunchScreen: UIViewController?
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configurePickerSheet()
        showPreloader()
        bind()
        viewModel?.didTriggerViewLoad()
    }
}

// MARK: - UITableViewController

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfElements ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeTableViewCell.identifier
            ) as? HomeTableViewCell,
            let model = viewModel?.displayModel(at: indexPath.row)
        else {
            return UITableViewCell()
        }
        
        cell.refresh(with: model)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {
            return
        }
        
        if indexPath.row == viewModel.numberOfElements - 1 {
            viewModel.didTriggerReachEndOfList()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? HomeTableViewCell else {
            return
        }
        
        cell.cancelDownloadTask()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didTriggerSelectItem(at: indexPath.row)
    }
}

// MARK: - Private

private extension HomeViewController {
    func configure() {
        addSubviews()
        setConstraints()
        configureView()
    }
    
    func addSubviews() {
        view.addSubview(headerView)
        headerView.addSubview(headerTitleLabel)
        headerView.addSubview(headerSubtitleLabel)
        headerView.addSubview(dateButton)
        headerView.addSubview(roverButton)
        headerView.addSubview(cameraButton)
        headerView.addSubview(saveButton)
        view.addSubview(stack)
        stack.addArrangedSubview(tableView)
        view.addSubview(historyButton)
        view.addSubview(centerActivityIndicatorView)
        view.addSubview(bottomActivityIndicatorView)
    }
    
    func setConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        headerTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(headerView.layoutMarginsGuide).inset(2)
            make.leading.equalToSuperview().inset(19)
            make.trailing.lessThanOrEqualTo(dateButton.snp.leading).inset(-19)
        }
        
        headerSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(headerTitleLabel.snp.bottom).inset(-2)
            make.leading.equalToSuperview().inset(19)
            make.trailing.lessThanOrEqualTo(dateButton.snp.leading).inset(-19)
        }
        
        dateButton.snp.makeConstraints { make in
            make.top.equalTo(headerView.layoutMarginsGuide).inset(14)
            make.trailing.equalToSuperview().inset(17)
        }
        
        roverButton.snp.makeConstraints { make in
            make.top.equalTo(headerSubtitleLabel.snp.bottom).inset(-22)
            make.leading.bottom.equalToSuperview().inset(20)
            make.width.equalTo(140)
            make.height.equalTo(38)
        }
        
        cameraButton.snp.makeConstraints { make in
            make.top.width.height.bottom.equalTo(roverButton)
            make.leading.equalTo(roverButton.snp.trailing).inset(-12)
        }
        
        saveButton.snp.makeConstraints { make in
            make.width.height.equalTo(38)
            make.centerX.equalTo(dateButton)
            make.centerY.equalTo(cameraButton)
        }

        stack.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        historyButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.layoutMarginsGuide)
            make.height.width.equalTo(70)
        }
        
        centerActivityIndicatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        bottomActivityIndicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.layoutMarginsGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = Color.backgroundOne.value
    }
    
    func showPreloader() {
        let fakeLoader = PreloaderAssembly.preloaderController()
        fakeLaunchScreen = fakeLoader
        self.displayController(fakeLoader, frame: self.view.bounds)
    }
    
    func hidePreloader() {
        self.hideController(fakeLaunchScreen)
        fakeLaunchScreen = nil
    }
    
    func bind() {
        viewModel?.modelPublisher
            .sink(receiveValue: { [weak self] photos in
                if photos.isEmpty {
                    self?.tableView.setNoDataPlaceholder("No data")
                } else {
                    self?.tableView.removeNoDataPlaceholder()
                }
                self?.tableView.reloadData()
                self?.hidePreloader()
            })
            .store(in: &cancellables)
        viewModel?.isCenterActiityIndicatorHiddenPublisher
            .sink(receiveValue: { [weak self] isHidden in
                isHidden
                    ? self?.centerActivityIndicatorView.stopAnimating()
                    : self?.centerActivityIndicatorView.startAnimating()
            })
            .store(in: &cancellables)
        
        viewModel?.isBottomActiityIndicatorHiddenPublisher
            .sink(receiveValue: { [weak self] isHidden in
                isHidden
                    ? self?.bottomActivityIndicatorView.stopAnimating()
                    : self?.bottomActivityIndicatorView.startAnimating()
            })
            .store(in: &cancellables)
        viewModel?.datePublisher
            .map { HelperUtilities.dateFormat($0, to: .MMMdyyyy) }
            .sink(receiveValue: { [weak self] dateString in
                self?.headerSubtitleLabel.text = dateString
            })
            .store(in: &cancellables)
        viewModel?.isPickerSheetHidden
            .sink(receiveValue: { [weak self] isHidden in
                self?.animatePickerSheet(isHidden: isHidden)
            })
            .store(in: &cancellables)
        viewModel?.pickerSheetViewModelPublisher
            .sink(receiveValue: { [weak self] viewModel in
                self?.pickerSheetView?.viewModel = viewModel
            })
            .store(in: &cancellables)
        viewModel?.roverPublisher
            .sink(receiveValue: { [weak self] rover in
                self?.roverButton.setTitle(rover, for: .normal)
            })
            .store(in: &cancellables)
        viewModel?.cameraPublisher
            .sink(receiveValue: { [weak self] camera in
                self?.cameraButton.setTitle(camera, for: .normal)
            })
            .store(in: &cancellables)
    }
    
    func animatePickerSheet(isHidden: Bool) {
        pickerSheetView?.view.isHidden = isHidden
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func configurePickerSheet() {
        let bottomSheet = PickerBottomSheetViewController()
        pickerSheetView = bottomSheet
        stack.addArrangedSubview(bottomSheet.view)
        bottomSheet.didMove(toParent: self)
    }
    
    @objc func dateButtonAction() {
        viewModel?.didTriggerDateButton()
    }
    
    @objc func roverButtonAction() {
        viewModel?.didTriggerRoverButton()
    }
    
    @objc func cameraButtonAction() {
        viewModel?.didTriggerCameraButton()
    }
    
    @objc func saveButtonAction() {
        viewModel?.didTriggerSaveButton()
    }
    
    @objc func historyButtonAction() {
        viewModel?.didTriggerHistoryButton()
    }
}
