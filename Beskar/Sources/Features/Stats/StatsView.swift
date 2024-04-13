//
//  StatsView.swift
//  Beskar
//
//  Created by Rusito on 13/04/2024.
//

import SwiftUI

struct StatsView: View {

    // MARK: Private Properties

    @ObservedObject
    private var viewModel: StatsViewModel = resolve()

    // MARK: Body

    var body: some View {
        Text("Hello world!")
    }
}

// MARK: - Previews

#if DEBUG
@available(*, unavailable)
struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
#endif
