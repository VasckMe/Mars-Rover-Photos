//
//  FilterHistoryViewController.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

import UIKit
import Combine

final class FilterHistoryViewController: UIViewController {
    
    var viewModel: FilterHistoryViewModelProtocol?
    
    private let navigationBarView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.accentOne.value
        return view
    }()
    
    private lazy var navigationBarBackButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back.png"), for: .normal)
        button.addTarget(self, action: #selector(navigationBarBackButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let navigationBarTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "History"
        label.font = Font.largeTitle.value
        label.textColor = Color.layerOne.value
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Color.backgroundOne.value
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(nibName: FilterHistoryTableViewCell.nibName, bundle: nil),
            forCellReuseIdentifier: FilterHistoryTableViewCell.identifier
        )
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        tableView.rowHeight = 136
        tableView.estimatedRowHeight = 136
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configure()
        viewModel?.didTriggerViewLoad()
    }
}

// MARK: - UITableViewDataSource

extension FilterHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfElements ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: FilterHistoryTableViewCell.identifier
            ) as? FilterHistoryTableViewCell,
            let displayItem = viewModel?.displayModel(at: indexPath.row)
        else {
            return UITableViewCell()
        }
        
        cell.refresh(with: displayItem)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FilterHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didTriggerSelectItem(at: indexPath.row)
    }
}

// MARK: - Private

private extension FilterHistoryViewController {
    func bind() {
        viewModel?.displayItemsPublisher
            .sink(receiveValue: { [weak self] filters in
                if filters.isEmpty {
                    self?.tableView.setNoDataPlaceholder("No data")
                } else {
                    self?.tableView.removeNoDataPlaceholder()
                }
                self?.tableView.reloadData()
            })
            .store(in: &cancellables)
    }
    
    func configure() {
        addSubivews()
        setConstraints()
    }
    
    func addSubivews() {
        view.addSubview(navigationBarView)
        navigationBarView.addSubview(navigationBarBackButton)
        navigationBarView.addSubview(navigationBarTitleLabel)
        view.addSubview(tableView)
    }
    
    func setConstraints() {
        navigationBarView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        navigationBarBackButton.snp.makeConstraints { make in
            make.top.equalTo(navigationBarView.layoutMarginsGuide).inset(14)
            make.leading.bottom.equalToSuperview().inset(20)
        }
        
        navigationBarTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationBarView.layoutMarginsGuide).inset(15)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualTo(navigationBarBackButton.snp.trailing).inset(-12)
            make.trailing.lessThanOrEqualToSuperview().inset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navigationBarView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc func navigationBarBackButtonAction() {
        viewModel?.didTriggerBackButton()
    }
}
