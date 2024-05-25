//
//  View+Spacer.swift
//  BeskarUI
//
//  Created by Rusito on 25/05/2024.
//

import UIKit

extension UIView {
    public static var spacer: UIView {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        view.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        return view
    }
}
