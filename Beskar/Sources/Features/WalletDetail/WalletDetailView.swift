//
//  WalletDetailView.swift
//  Beskar
//
//  Created by Igor on 22/03/2021.
//

import BeskarUI
import TinyConstraints
import UIKit

final class WalletDetailView: UIView {

    // MARK: Subviews

    private(set) lazy var nameLabel = Label(
        size: .typeLarge,
        color: .beskar.primary,
        identifier: A.WalletDetailView.name
    )

    private(set) lazy var summaryLabel = Label(
        size: .small,
        color: .beskar.secondary,
        identifier: A.WalletDetailView.summary
    )

    private(set) lazy var amountLabel = Label(
        size: .large,
        color: .beskar.primary,
        text: "WALLET_DETAIL_AMOUNT_HEADER".localized,
        identifier: A.WalletDetailView.amountHeader
    )

    private(set) lazy var transactionsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = A.WalletDetailView.table
        tableView.register(TransactionCell.self)
        return tableView
    }()

    private(set) lazy var actionsCollection: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: actionsLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(WalletActionItemViewCell.self)
        return collectionView
    }()

    private lazy var transactionsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(transactionsTableView)
        transactionsTableView.edgesToSuperview()
        return view
    }()

    private lazy var actionsLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .zero
        return layout
    }()

    // MARK: Private Properties

    /// The colors to be used to create the gradient for the transactions container
    private var gradientColors: [CGColor] {
        [
            UIColor.clear.cgColor,
            (backgroundColor ?? .clear).cgColor,
            (backgroundColor ?? .clear).cgColor,
            UIColor.clear.cgColor,
        ]
    }

    /// The start/end locations to be followed by the gradient
    private var gradientLocations: [NSNumber] {
        [
            0.0, // Start on the very top
            0.1, // And stop so that the first cell is visible
            0.9, // Start almost at the bottom to that the last cell is also visible
            1.0, // And end at the very bottom
        ]
    }

    // MARK: Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UIView Overrides

    override func layoutSubviews() {
        super.layoutSubviews()
        setUpTransactionsGradient()
    }

    // MARK: Private Methods

    private func setUpViews() {
        addSubviews(
            nameLabel,
            summaryLabel,
            amountLabel,
            actionsCollection,
            transactionsContainer
        )

        nameLabel.topToSuperview(offset: Spacing.small.rawValue, usingSafeArea: true)
        nameLabel.leadingToSuperview(offset: Spacing.small.rawValue)
        nameLabel.trailingToSuperview(offset: Spacing.small.rawValue)

        summaryLabel.topToBottom(of: nameLabel, offset: Spacing.small.rawValue)
        summaryLabel.leadingToSuperview(offset: Spacing.small.rawValue)
        summaryLabel.trailingToSuperview(offset: Spacing.small.rawValue)

        amountLabel.topToBottom(of: summaryLabel, offset: Spacing.small.rawValue)
        amountLabel.leadingToSuperview(offset: Spacing.small.rawValue)
        amountLabel.trailingToSuperview(offset: Spacing.small.rawValue)

        actionsCollection.topToBottom(of: amountLabel, offset: Spacing.small.rawValue)
        actionsCollection.leadingToSuperview(offset: Spacing.medium.rawValue)
        actionsCollection.trailingToSuperview(offset: Spacing.medium.rawValue)
        actionsCollection.height(Size.medium.rawValue)

        transactionsContainer
            .topToBottom(of: actionsCollection, offset: Spacing.extraSmall.rawValue)
        transactionsContainer.leadingToSuperview()
        transactionsContainer.trailingToSuperview()
        transactionsContainer.bottomToSuperview(usingSafeArea: true)
    }

    private func setUpTransactionsGradient() {
        let gradient = CAGradientLayer(layer: transactionsContainer.layer)
        gradient.colors = gradientColors
        gradient.locations = gradientLocations
        gradient.frame = transactionsContainer.bounds
        transactionsContainer.layer.mask = gradient
    }
}

// MARK: - UICollectionViewDelegate Conformance

/// Ensure that our collection view cell are aligned to the center
extension WalletDetailView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        else { return .zero }

        let numberOfItems = CGFloat(collectionView.numberOfItems(inSection: section))
        let combinedInteritemSpacing = ((numberOfItems - 1)  * flowLayout.minimumInteritemSpacing)
        let combinedItemWidth = (numberOfItems * flowLayout.itemSize.width)

        let combinedTotalWidth = combinedItemWidth + combinedInteritemSpacing
        let padding = (collectionView.frame.width - combinedTotalWidth) / 2
        return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    }
}
