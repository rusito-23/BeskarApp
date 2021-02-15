//
//  ViewModel.swift
//  Beskar
//
//  Created by Igor on 15/02/2021.
//

import Combine

/// Protocol that defines a view model
protocol ViewModel: ObservableObject {
    /// Starts the actions that need to be taken in the view model
    func start()
}

/// Default view model implementation
extension ViewModel {
    func start() {}
}
