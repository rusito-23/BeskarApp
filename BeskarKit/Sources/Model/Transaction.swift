//
//  Transaction.swift
//  BeskarKit
//
//  Created by Igor on 07/02/2021.
//

import class RealmSwift.Object
import struct RealmSwift.LinkingObjects
import protocol RealmSwift.RealmEnum

/// Transaction
/// - Description
///     Saves information about a particular transaction, linked to a wallet
///     The currency is given by the wallet to which this transaction belongs.

public class Transaction: Object {

    // MARK: Properties Names

    struct PropertiesNames {
        static let id = "id"
    }

    // MARK: Persistent Properties

    /// An unique identifier, not available for public usage
    @objc dynamic var id: String

    /// A required user description of the transaction
    @objc dynamic var summary: String

    /// The amount gained/lost in the transaction
    @objc dynamic var amount: Double

    /// The kind of the transaction
    /// Indicates if the wallet lost or gained with this transaction
    @objc dynamic var kind: Kind

    /// The date on which the transaction was performed
    @objc dynamic var date: Date

    /// The wallet that contains this particular transaction
    let wallet = LinkingObjects(
        fromType: Wallet.self,
        property: Wallet.PropertiesNames.transactions
    )

    // MARK: Kind

    /// Kind
    /// - Description
    ///     This enum allows us to detect if the transaction was positive or negative
    ///     Indicates if the wallet lost or gained with this transaction
    @objc public enum Kind: Int, RealmEnum {
        case plus
        case minus
    }

    // MARK: Initializer

    public init(
        uuid: UUID = UUID(),
        summary: String,
        amount: Double,
        kind: Kind,
        date: Date
    ) {
        self.id = uuid.uuidString
        self.summary = summary
        self.amount = amount
        self.kind = kind
        self.date = date
    }

    // MARK: Object Overrides

    override public static func primaryKey() -> String { "id" }
}
