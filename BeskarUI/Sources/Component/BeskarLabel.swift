//
//  BeskarLabel.swift
//  BeskarUI
//
//  Created by Igor on 30/01/2021.
//

import UIKit

public class BeskarLabel: UILabel {

    // MARK: - Initializers

    public init(
        size: UIFont.Beskar.Size,
        weight: UIFont.Beskar.Weight = .init(),
        color: UIColor = UIColor.beskar.primary
    ) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.beskar.build(size, weight)
        textColor = color
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        textAlignment = .center
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
