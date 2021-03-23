//
//  SplashView.swift
//  Beskar
//
//  Created by Igor on 23/03/2021.
//

import BeskarUI
import UIKit

final class SplashView: UIView {

    // MARK: Subviews

    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.beskar.create(.clearIcon)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setUpViews() {
        addSubview(iconView)
        iconView.size(Size.large.size)
        iconView.centerInSuperview()
    }
}
