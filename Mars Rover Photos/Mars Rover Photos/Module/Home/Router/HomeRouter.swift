//
//  HomeRouter.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 3.04.24.
//

import UIKit

protocol HomeRouterProtocol {
    func openDetailScreen(input: DetailInputModel)
    func openDatePopupScreen(delegate: DatePopupDelegate)
    func showFilterHistoryScreen(delegate: FilterHistoryDelegate)
    func showSaveAlert(title: String, subtitle: String, completion: @escaping ()->())
}

final class HomeRouter: HomeRouterProtocol {
    weak var view: HomeViewController?
    
    func openDetailScreen(input: DetailInputModel) {
        let detailScreen = DetailAssembly.detailController(input: input)
        view?.navigationController?.pushViewController(detailScreen, animated: true)
    }
    
    func openDatePopupScreen(delegate: DatePopupDelegate) {
        let datePopupScreen = DatePopupAssembly.datePopupController(delegate: delegate)
        datePopupScreen.modalPresentationStyle = .overFullScreen
        view?.navigationController?.present(
            datePopupScreen,
            animated: false,
            completion: {
                guard
                    let view = datePopupScreen as? DatePopupViewControllerProtocol
                else {
                    return
                }
                
                view.show()
            })
    }
    
    func showFilterHistoryScreen(delegate: FilterHistoryDelegate) {
        let filterHistoryScreen = FilterHistoryAssembly.filterHistoryController(delegate: delegate)
        view?.navigationController?.pushViewController(filterHistoryScreen, animated: true)
    }
    
    func showSaveAlert(title: String, subtitle: String, completion: @escaping () -> ()) {
        let alertController = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            completion()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        view?.navigationController?.present(alertController, animated: true)
    }
}
