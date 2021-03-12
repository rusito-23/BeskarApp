//
//  Separator.swift
//  BeskarUI
//
//  Created by Igor on 14/02/2021.
//

import UIKit

/// A simple separator view
public class Separator: UIView {

    // MARK: Types

    public enum Kind {
        case horizontal
        case vertical
    }

    public enum Size: CGFloat {
        case extraSmall = 0.5
        case small = 1.0
        case medium = 1.5
        case large = 2.0
    }

    // MARK: Initializers

    public init(
        color: UIColor,
        size: Size,
        kind: Kind
    ) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = color

        switch kind {
        case .horizontal:
            heightAnchor.constraint(
                equalToConstant: size.rawValue
            ).isActive = true
        default:
            widthAnchor.constraint(
                equalToConstant: size.rawValue
            ).isActive = true
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
