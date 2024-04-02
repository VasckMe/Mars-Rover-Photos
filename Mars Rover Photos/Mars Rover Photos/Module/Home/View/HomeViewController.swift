//
//  HomeViewController.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

import UIKit

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
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Color.clear.value
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        configureView()
        showPreloader()
    }
}

// MARK: - Private

private extension HomeViewController {
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
            make.trailing.bottom.equalToSuperview().inset(20)
            make.leading.equalTo(cameraButton.snp.trailing).inset(-23)
            make.width.height.equalTo(38)
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
    }
    
    func configureView() {
        view.backgroundColor = Color.backgroundOne.value
    }
    
    func showPreloader() {
        let view = PreloaderAssembly.preloaderController()
        self.displayController(view, frame: self.view.bounds)
    }
}
