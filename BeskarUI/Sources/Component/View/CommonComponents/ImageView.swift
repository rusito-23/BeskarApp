//
//  ImageView.swift
//  BeskarUI
//
//  Created by Igor on 11/02/2021.
//

import UIKit

/// BeskarUI Image View
///
/// # Description #
/// Contains custom initializers to use the BeskarUI image set
/// and sets up the default style values.
public class ImageView: UIImageView {

    // MARK: Initializers

    /// Initialize with an image from the Beskar System Images Set
    public init(
        _ image: UIImage.Beskar.Name.System,
        identifier: String? = nil
    ) {
        super.init(image: UIImage.beskar.create(image))
        setUp(with: identifier)
    }

    /// Initialize with an image from the Beskar Custom Images Set
    public init(
        _ image: UIImage.Beskar.Name.Custom,
        identifier: String? = nil
    ) {
        super.init(image: UIImage.beskar.create(image))
        setUp(with: identifier)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setUp(with identifier: String?) {
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
        accessibilityIdentifier = identifier
    }
}
