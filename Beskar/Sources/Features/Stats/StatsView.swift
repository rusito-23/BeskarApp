//
//  StatsView.swift
//  Beskar
//
//  Created by Rusito on 13/04/2024.
//

import BeskarUI
import Charts
import SwiftUI

struct StatsView: View {

    // MARK: Private Properties

    @ObservedObject private var viewModel: StatsViewModel = resolve()

    // MARK: Body

    var body: some View {
        VStack {
            chart
        }
        .padding(Spacing.typeMedium.rawValue)
        .onAppear {
            viewModel.start()
        }
    }

    private var chart: some View {
        Chart {
            ForEach(viewModel.wallets, id: \.self) { wallet in
                BarMark(
                    x: .value(Content.currency.localized,  wallet.currency.displayName),
                    y: .value(Content.amount.localized, wallet.amount)
                )
                .foregroundStyle(by: .value(Content.name.localized, wallet.name))
            }
        }
    }
}

// MARK: - Content

private extension StatsView {
    enum Content: String {
        case currency = "CURRENCY"
        case amount = "AMOUNT"
        case name = "WALLET_NAME"

        var localized: String {
            rawValue.localized
        }
    }
}

// MARK: - Previews

#Preview {
    StatsView()
}
