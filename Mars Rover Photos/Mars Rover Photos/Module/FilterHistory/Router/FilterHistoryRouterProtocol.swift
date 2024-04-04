//
//  FilterHistoryRouterProtocol.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

protocol FilterHistoryRouterProtocol {
    func closeFilterHistoryScreen()
    func showFilterActionAlertSheet(
        useCompletion: @escaping ()->()?,
        deleteCompletion: @escaping ()->()?
    )
}
