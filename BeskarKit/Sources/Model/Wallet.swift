//
//  Wallet.swift
//  BeskarKit
//
//  Created by Igor on 30/01/2021.
//

import class RealmSwift.Object
import class RealmSwift.List

/// Wallet
/// - Description
///     Saves information about a particular User Wallet
///     This will be used to save general information about a money source
///     It will save a list of transactions, linked by the many-to-one relationship.
///     The class is prepared to be saved into the Realm Database

public class Wallet: Object {

    // MARK: Properties Names

    struct PropertiesNames {
        static let key = "key"
        static let transactions = "transactions"
    }

    // MARK: Persistent Properties

    /// An unique identifier, not available for public usage
    @objc dynamic var key: String = UUID().uuidString

    /// The name of the wallet
    @objc public dynamic var name: String = ""

    /// An optional description of the wallet
    @objc public dynamic var summary: String?

    /// The date in which the wallet was created (or started to be available)
    @objc public dynamic var creationDate: Date = Date()

    /// The kind of currency managed in this wallet
    /// A walled will handle a single kind of currency
    @objc public dynamic var currency: Currency = .dollars

    /// The list of transactions made in this wallet
    let transactions = List<Transaction>()

    // MARK: Initializers

    public convenience init(
        name: String,
        summary: String? = nil,
        creationDate: Date,
        currency: Currency
    ) {
        self.init()
        self.name = name
        self.summary = summary
        self.creationDate = creationDate
        self.currency = currency
    }

    // MARK: Object Overrides

    override public static func primaryKey() -> String { PropertiesNames.key }
}
