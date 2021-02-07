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

    public typealias Completion = (Result<Bool, AuthError>) -> Void

    public enum AuthError: Error {
        /// Authentication failed
        case unauthorized
        /// Device authentication wan't configured
        case unavailable
        /// User or system canceled request
        case canceled
    }

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
        guard context.canEvaluatePolicy(
            policy,
            error: &error
        ), error as? LAError == nil else {
            return false
        }

        return true
    }

    public func authenticate(
        reason: String,
        completion: @escaping Completion
    ) {
        context.evaluatePolicy(
            policy,
            localizedReason: reason
        ) { (success, err)  in
            guard !success, let error = err as? LAError else {
                completion(.success(success))
                return
            }

            switch error.code {
            case .authenticationFailed:
                completion(.failure(.unauthorized))
            case .userCancel,
                 .systemCancel,
                 .appCancel,
                 .userFallback,
                 .touchIDLockout:
                completion(.failure(.canceled))
            case .invalidContext,
                 .touchIDNotAvailable,
                 .touchIDNotEnrolled,
                 .biometryNotAvailable,
                 .biometryNotEnrolled,
                 .notInteractive,
                 .passcodeNotSet:
                completion(.failure(.unavailable))
            @unknown default:
                completion(.failure(.unavailable))
            }
        }
    }
}
