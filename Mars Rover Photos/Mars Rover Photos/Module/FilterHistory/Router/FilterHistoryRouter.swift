//
//  FilterHistoryRouter.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

import UIKit

final class FilterHistoryRouter: FilterHistoryRouterProtocol {
    weak var view: FilterHistoryViewController?
    
    func showFilterActionAlertSheet(useCompletion: @escaping ()->()?, deleteCompletion: @escaping ()->()?) {
        let alertController = UIAlertController(title: nil, message: "Menu Filter", preferredStyle: .actionSheet)
        let useAction = UIAlertAction(title: "Use", style: .default) { _ in
            useCompletion()
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            deleteCompletion()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(useAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        view?.navigationController?.present(alertController, animated: true)
    }
    
    func closeFilterHistoryScreen() {
        view?.navigationController?.popViewController(animated: true)
    }
}
