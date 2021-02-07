//
//  Dimensions.swift
//  BeskarUI
//
//  Created by Igor on 30/01/2021.
//

import UIKit

public enum Spacing: CGFloat {
    case extraLarge = 64.0
    case large = 46.0
    case typeMedium = 32.0
    case medium = 16.0
    case small = 8.0
    case extraSmall = 4.0
    case zero = 0
}

public struct Border {
    public enum Width: CGFloat {
        case large = 2.0
        case medium = 1.5
        case small = 1.0
        case extraSmall = 0.5
    }

    public enum Radius: CGFloat {
        case large = 50.0
        case medium = 20.0
        case small = 10.0
        case extraSmall = 5.0
    }
}

public enum Size: CGFloat {
    case large = 100.0
    case medium = 50.0
    case small = 25.0
}
