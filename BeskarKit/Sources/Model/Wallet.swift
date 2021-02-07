//
//  Wallet.swift
//  BeskarKit
//
//  Created by Igor on 30/01/2021.
//

import class RealmSwift.Object

public class Wallet: Object {

    // MARK: Model Properties

    @objc public dynamic var name: String
    @objc public dynamic var summary: String
    @objc public dynamic var creationDate: Date
    @objc public dynamic var currencyName: String

    // MARK: Computed Properties

    public var currency: Currency? {
        get { Currency(rawValue: currencyName) }
        set { currencyName = newValue?.rawValue ?? "" }
    }

    // MARK: Initializers

    public init(
        name: String,
        summary: String,
        creationDate: Date,
        currencyName: String
    ) {
        self.name = name
        self.summary = summary
        self.creationDate = creationDate
        self.currencyName = currencyName
    }
}
