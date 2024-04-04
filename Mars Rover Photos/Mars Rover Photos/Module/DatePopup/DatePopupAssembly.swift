//
//  DatePopupAssembly.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 3.04.24.
//

import UIKit

struct DatePopupAssembly {
    static func datePopupController(delegate: DatePopupDelegate) -> UIViewController {
        let view = DatePopupViewController(
            nibName: DatePopupViewController.nibName,
            bundle: nil
        )
        let router = DatePopupRouter()
        router.view = view
        
        let viewModel = DatePopupViewModel(router: router, delegate: delegate)
        view.viewModel = viewModel
        
        return view
    }
}
