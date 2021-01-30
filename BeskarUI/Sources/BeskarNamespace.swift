//
//  Beskar.swift
//  Beskar
//
//  Created by Igor on 28/01/2021.
//
// Foundation of the `Beskar` Namespace
// To avoid name clashes and provides a simpler way to access
// extended functionality on different UIKit classes.

/// Base is the Type on which we are going to create the extension
public protocol BeskarNamespace {
    associatedtype Base

    var beskar: Base { get }
    static var beskar: Base.Type { get }
}

/// Default implementation is to wrap self to extend functionalities
public extension BeskarNamespace {
    typealias Beskar = BeskarWrapper<Self>

    var beskar: BeskarWrapper<Self> { BeskarWrapper<Self>(base: self) }
    static var beskar: BeskarWrapper<Self>.Type { BeskarWrapper.self }
}

/// The wrapper that will contain the extensions
public struct BeskarWrapper<Base> {
    var base: Base
}
