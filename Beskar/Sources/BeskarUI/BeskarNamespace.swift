//
//  Beskar.swift
//  Beskar
//
//  Created by Igor on 28/01/2021.
//

import Foundation

protocol BeskarNamespace {
    associatedtype Base

    var beskar: Base { get }
    static var beskar: Base.Type { get }
}

extension BeskarNamespace {
    var beskar: TypeWrapper<Self> { TypeWrapper<Self>(value: self) }
    static var beskar: TypeWrapper<Self>.Type { TypeWrapper.self }
}

public struct TypeWrapper<T> {
    var value: T
}
