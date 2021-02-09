//
//  DataService.swift
//  BeskarKit
//
//  Created by Igor on 08/02/2021.
//

import RealmSwift

/// - Description
/// Defines common behavior used to manage persistent data in the app.

open class DataService<Data: Object> {

    // MARK: Types

    public typealias FetchResult = (Result<[Data], DataServiceError>) -> Void
    public typealias WriteResult = (Result<Bool, DataServiceError>) -> Void

    /// The possible Data Service Errors
    public enum DataServiceError: Error {
        /// The Realm DB was not available for usage
        case unavailable
        /// A Thread Safe Reference was lost
        case concurrencyFailure
        /// Generic Realm failure
        case failure
    }

    // MARK: Internal Properties

    /// Realm default configuration
    var configuration: Realm.Configuration { .defaultConfiguration }

    /// The queue on which the db calls are made
    var serviceQueue: DispatchQueue {
        DispatchQueue(label: "\(Data.self)Queue", qos: .background)
    }

    /// The queue on which the result of the call should be posted
    var resultQueue: DispatchQueue {
        DispatchQueue.main
    }

    /// Computed Realm instance to keep it thread safe
    var realm: Realm? { try? Realm() }

    // MARK: Public Initializer

    public init() {}

    // MARK: Internal Methods

    /// Retrieve all objects of the given data type from the DB
    public func fetch(
        _ completion: @escaping FetchResult
    ) {
        serviceQueue.async { [weak self] in
            guard let self = self else { return }

            // Initialize realm
            guard let realm = self.realm else {
                self.resultQueue.async { completion(.failure(.unavailable)) }
                return
            }

            // Get data and create thread safe references
            let references = ThreadSafeReference(to: realm.objects(Data.self))
            self.resultQueue.async {

                // Initialize realm
                guard let realm = self.realm else {
                    completion(.failure(.unavailable))
                    return
                }

                // Resolve references
                guard let results = realm.resolve(references) else {
                    completion(.failure(.concurrencyFailure))
                    return
                }

                // Send data as result
                completion(.success(Array(results)))
            }
        }
    }

    /// Write an object of the given data type in the DB
    public func write(
        _ object: Data,
        _ completion: @escaping WriteResult
    ) {
        serviceQueue.async { [weak self] in
            guard let self = self else { return }

            // Initialize realm
            guard let realm = self.realm else {
                completion(.failure(.unavailable))
                return
            }

            // Write object
            guard let _ = try? realm.write({ realm.add(object) }) else {
                completion(.failure(.concurrencyFailure))
                return
            }

            completion(.success(true))
        }
    }
}
