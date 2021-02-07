//
//  AuthService.swift
//  BeskarKit
//
//  Created by Igor on 03/02/2021.
//

import Foundation
import LocalAuthentication

// MARK: - Protocol

public protocol AuthServiceProtocol {
    /// Check if the authentication service is available
    func isAvailable() -> Bool

    /// Start authentication flow
    func authenticate(
        reason: String,
        completion: @escaping AuthService.Completion
    )
}

// MARK: - Implementation

public final class AuthService: AuthServiceProtocol {

    // MARK: Types

    public typealias Completion = (Bool) -> Void

    // MARK: Static Properties

    public static let `default` = AuthService()

    // MARK: Private Properties

    private let context: LAContext
    private let policy: LAPolicy

    // MARK: Public Initializer

    public init(
        context: LAContext = LAContext(),
        policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
    ) {
        self.context = context
        self.policy = policy
    }
}

// MARK: - Auth Service Protocol Conformance

extension AuthService {
    public func isAvailable() -> Bool {
        var error: NSError?

        let canEvaluatePolicy = context.canEvaluatePolicy(
            policy,
            error: &error
        )

        if let policyError = error as? LAError {
            switch policyError.code {
            // TODO: check for policy error code
            default: print("Authentication Failed")
            }
            return false
        }

        return canEvaluatePolicy
    }

    public func authenticate(
        reason: String,
        completion: @escaping Completion
    ) {
        context.evaluatePolicy(
            policy,
            localizedReason: reason
        ) { (success, _)  in completion(success) }
    }
}
