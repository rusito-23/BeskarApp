//
//  CoordinatorSpy.swift
//  BeskarTests
//
//  Created by Igor on 27/03/2021.
//

@testable import Beskar

final class CoordinatorSpy: BaseCoordinator {

    // MARK: Properties

    private(set) var didStop: Bool = false
    private(set) var didStart: Bool = false

    // MARK: Methods

    override func start() {
        super.start()
        didStart = true
    }

    override func stop() {
        super.stop()
        didStop = true
    }
}
