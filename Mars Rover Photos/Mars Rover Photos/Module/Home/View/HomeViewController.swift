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
        label.text = "June 6, 2019"
        label.font = Font.body2.value
        label.textColor = Color.layerOne.value
        return label
    }()
    
    private let dateButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "calendar"), for: .normal)
        return button
    }()
    
    private let roverButton: UIButton = {
        let button = UIButton()
        button.setTitle("All", for: .normal)
        button.setImage(UIImage(named: "rover"), for: .normal)
        button.titleLabel?.font = Font.body2.value
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
        return button
    }()
    
    private let cameraButton: UIButton = {
        let button = UIButton()
        button.setTitle("All", for: .normal)
        button.setImage(UIImage(named: "camera"), for: .normal)
        button.titleLabel?.font = Font.body2.value
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
        return button
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
        return button
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
    
    private let historyButton: UIButton = {
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
        return button
    }()
    
    private var bottomActivityIndicatorView: UIActivityIndicatorView = {
        let bottomIndicatorView = UIActivityIndicatorView(style: .medium)
        bottomIndicatorView.hidesWhenStopped = true
        bottomIndicatorView.color = Color.accentOne.value
        return bottomIndicatorView
    }()
    private var fakeLaunchScreen: UIViewController?
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        showPreloader()
        viewModel?.didTriggerViewLoad()
        bind()
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
        print("Display: \(indexPath.row)")
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
        view.addSubview(tableView)
        view.addSubview(historyButton)
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

        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        historyButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.layoutMarginsGuide)
            make.height.width.equalTo(70)
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
            .sink(receiveCompletion: { [weak self] _ in
                self?.tableView.reloadData()
                self?.hidePreloader()
            }, receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
                self?.hidePreloader()
            })
            .store(in: &cancellables)
        
        viewModel?.showIndicatorPublisher
            .sink(receiveValue: { [weak self] isActive in
                isActive
                ? self?.bottomActivityIndicatorView.startAnimating()
                : self?.bottomActivityIndicatorView.stopAnimating()
            })
            .store(in: &cancellables)
    }
}
