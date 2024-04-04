//
//  HomeViewModel.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

import Foundation
import Combine

final class HomeViewModel {
    private var networkService: NetworkServiceProtocol
    private let router: HomeRouterProtocol
    
    var modelPublisher = PassthroughSubject<[Photo], NetworkError>()
    var isCenterActiityIndicatorHiddenPublisher = CurrentValueSubject<Bool, Never>(true)
    var isBottomActiityIndicatorHiddenPublisher = CurrentValueSubject<Bool, Never>(true)
    var isPickerSheetHidden = CurrentValueSubject<Bool, Never>(true)
    var pickerSheetViewModel = PassthroughSubject<PickerBottomSheetViewModelProtocol, Never>()
    
    var datePublisher = CurrentValueSubject<Date, Never>(Date())
    var roverPublisher = CurrentValueSubject<String, Never>(RoverType.all.rawValue)
    var cameraPublisher = CurrentValueSubject<String, Never>(CameraType.all.rawValue)

    var numberOfElements: Int {
        models.count
    }
    
    var models: [Photo] = []
    private var displayModels: [HomeCellItem] = []
    
    init(networkService: NetworkServiceProtocol, router: HomeRouterProtocol) {
        self.networkService = networkService
        self.router = router
    }
}

// MARK: - DatePopupDelegate

extension HomeViewModel: DatePopupDelegate {
    func save(date: Date) {
        datePublisher.send(date)
        fetch()
    }
}

// MARK: - HomeViewModelProtocol

extension HomeViewModel: HomeViewModelProtocol {
    func didTriggerDateButton() {
        router.openDatePopupScreen(delegate: self)
    }
    
    func displayModel(at index: Int) -> HomeCellItem? {
        guard let viewModel = displayModels[safe: index] else {
            return nil
        }
        
        return viewModel
    }
    
    func didTriggerRoverButton() {
        let inputModel = PickerBottomSheetInputmodel(
            title: "Rover",
            displayItems: RoverType.allCases.map {PickerDisplayItem(name: $0.rawValue)}
        )
        
        let isPickerHidden = isPickerSheetHidden.value
        let roverViewModel = RoverPickerBottomSheetViewModel(input: inputModel, delegate: self)
        
        if isPickerHidden {
            pickerSheetViewModel.send(roverViewModel)
            isPickerSheetHidden.send(!isPickerHidden)
        } else {
            pickerSheetViewModel.send(roverViewModel)
        }        
    }
    
    func didTriggerCameraButton() {
        let inputModel = PickerBottomSheetInputmodel(
            title: "Camera",
            displayItems: CameraType.allCases.map {PickerDisplayItem(name: $0.rawValue)}
        )
        
        let isPickerHidden = isPickerSheetHidden.value
        let cameraViewModel = CameraPickerBottomSheetViewModel(input: inputModel, delegate: self)
        
        if isPickerHidden {
            pickerSheetViewModel.send(cameraViewModel)
            isPickerSheetHidden.send(!isPickerHidden)
        } else {
            pickerSheetViewModel.send(cameraViewModel)
        }
    }
    
    func didTriggerViewLoad() {
        fetch()
    }
    
    func didTriggerReachEndOfList() {
        fetchNext()
    }
    
    func didTriggerSelectItem(at index: Int) {
        guard let model = models[safe: index] else {
            return
        }
        
        router.openDetailScreen(input: DetailInputModel(imageStringURL: model.imageStringURL))
    }
}

// MARK: - RoverPickerBottomSheetDelegate

extension HomeViewModel: RoverPickerBottomSheetDelegate {
    func save(rover: String) {
        roverPublisher.send(rover)
        fetch()
    }
    
    func closePickerBottomSheet() {
        isPickerSheetHidden.send(true)
    }
}

// MARK: - CameraPickerBottomSheetDelegate

extension HomeViewModel: CameraPickerBottomSheetDelegate {
    func save(camera: String) {
        cameraPublisher.send(camera)
        fetch()
    }
}

// MARK: - Private

private extension HomeViewModel {
    func fetch() {
        isCenterActiityIndicatorHiddenPublisher.send(false)
        
        guard
            let roverType = RoverType(rawValue: roverPublisher.value),
            let cameraType = CameraType(rawValue: cameraPublisher.value)
        else {
            return
        }
        
        let dateString = HelperUtilities.dateFormat(datePublisher.value, to: .yyyyMMdd)
        let cameraString: String? = cameraType == .all ? nil : cameraType.rawValue
        
        Task {
            do {
                let photos = try await networkService.fetchNew(rover: roverType, camera: cameraString, date: dateString)
                await MainActor.run {
                    models = photos
                    displayModels = photos.map { HomeCellItem(photo: $0) }
                    modelPublisher.send(photos)
                    isCenterActiityIndicatorHiddenPublisher.send(true)
                }
            } catch {
                await MainActor.run {
                    models = []
                    displayModels = []
                    modelPublisher.send(completion: .failure(error as? NetworkError ?? .unknown))
                    isCenterActiityIndicatorHiddenPublisher.send(true)
                }
            }
        }
    }
    
    func fetchNext() {
        guard !networkService.isLoading else {
            return
        }
        
        isBottomActiityIndicatorHiddenPublisher.send(false)
        
        guard
            let roverType = RoverType(rawValue: roverPublisher.value),
            let cameraType = CameraType(rawValue: cameraPublisher.value)
        else {
            return
        }
        
        let dateString = HelperUtilities.dateFormat(datePublisher.value, to: .yyyyMMdd)
        let cameraString: String? = cameraType == .all ? nil : cameraType.rawValue
        
        Task {
            do {
                let photos = try await networkService.fetchNext(rover: roverType, camera: cameraString, date: dateString)
                await MainActor.run {
                    models.append(contentsOf: photos)
                    displayModels = models.map { HomeCellItem(photo: $0) }
                    modelPublisher.send(models)
                    isBottomActiityIndicatorHiddenPublisher.send(true)
                }
            } catch {
                await MainActor.run {
                    models = []
                    displayModels = []
                    modelPublisher.send(completion: .failure(error as? NetworkError ?? .unknown))
                    isBottomActiityIndicatorHiddenPublisher.send(true)
                }
            }
        }
    }
}
