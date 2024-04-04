//
//  HomeRouterProtocol.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

protocol HomeRouterProtocol {
    func openDetailScreen(input: DetailInputModel)
    func openDatePopupScreen(delegate: DatePopupDelegate)
    func showFilterHistoryScreen(delegate: FilterHistoryDelegate)
    func showSaveAlert(title: String, subtitle: String, completion: @escaping ()->())
}
