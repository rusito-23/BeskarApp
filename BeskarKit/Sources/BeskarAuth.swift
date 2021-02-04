//
//  BeskarAuth.swift
//  BeskarKit
//
//  Created by Igor on 03/02/2021.
//

import CryptoKit
import CommonCrypto
import Foundation
import Security

// MARK: - Errors

public enum BeskarAuthError: LocalizedError {
    case localError
    case unauthorized
}

// MARK: - Protocol

public protocol BeskarAuthProtocol {

    /// Check if a token exists
    func canLogIn() throws

    /// Register token
    func signIn(_ token: String) throws

    /// Authorize using the given token
    func logIn(with token: String) throws

    /// Update token
    func update(_ newToken: String) throws

    /// Clear token
    func clear() throws
}

// MARK: - Implementation

final class BeskarAuth: BeskarAuthProtocol {

    // MARK: - Constants

    private struct Constants {
        static let userAccount = "BeskarService"
        static let accessGroup = "Beskar"
        static let passwordKey = "BeskarAuthToken"
        static let salt = "x4vV8bGgqqmQwgCoyXFQj+(o.nUNQhVP7ND"
        static let hexaFormat = "%02x"
    }

    // MARK: - Beskar Account Protocol Conformance

    public func canLogIn() throws {
        guard load(key: Constants.passwordKey) != nil
        else { throw BeskarAuthError.localError }
    }

    public func signIn(_ token: String) throws {
        guard save(key: Constants.passwordKey, value: try encrypt(token))
        else { throw BeskarAuthError.localError }
    }

    public func logIn(with token: String) throws {
        guard let currentToken = load(
            key: Constants.passwordKey
        ) else { throw BeskarAuthError.localError }

        guard try encrypt(token).elementsEqual(currentToken)
        else { throw BeskarAuthError.unauthorized }
    }

    public func update(_ newToken: String) throws {
        guard
            remove(key: Constants.passwordKey),
            save(key: Constants.passwordKey, value: try encrypt(newToken))
        else { throw BeskarAuthError.localError }
    }

    public func clear() throws {
        guard remove( key: Constants.passwordKey )
        else { throw BeskarAuthError.localError }
    }
}

// MARK: - Keychain Access Wrapper

extension BeskarAuth {

    /// Save a Keychain Item using the given key and value
    private func save(key: String, value: String) -> Bool {
        // Create Data from value
        let data = value.data(
            using: .utf8,
            allowLossyConversion: false
        ) as Any

        // Create Keychain Query
        let query = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ] as [String : Any]

        // Delete any existing items
        SecItemDelete(query as CFDictionary)

        // Add the new keychain item
        return SecItemAdd(
            query as CFDictionary, nil
        ) == noErr
    }

    /// Load a Keychain Item using the given key as String
    private func load(key: String) -> String? {
        // Create Keychain Query
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue ?? true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ] as [String : Any]

        // Retrieve data from Keychain
        var dataTypeRef: AnyObject?
        guard
            SecItemCopyMatching(
                query as CFDictionary,
                &dataTypeRef
            ) == noErr,
            let data = dataTypeRef as? Data
        else { return nil }

        // Convert Data to String
        return String(decoding: data, as: UTF8.self)
    }

    /// Remove item from Keychain
    private func remove(key: String) -> Bool {
        // Create Keychain Query
        let query = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key
        ] as [String : Any]

        // Delete any existing items
        return SecItemDelete(
            query as CFDictionary
        ) == noErr
    }
}

// MARK: - Encryption Helpers

extension BeskarAuth {

    /// Encrypt password
    private func encrypt(_ token: String) throws -> String {
        // Add salt to token
        let saltedToken = "\(token)\(Constants.salt)"

        // Convert to Data
        guard let data = saltedToken.data(using: .utf8)
        else { throw BeskarAuthError.localError }

        // Encrypt the Data and convert back to string
        return SHA256.hash(data: data).compactMap {
            String(format: Constants.hexaFormat, $0)
        }.joined()
    }
}
