//
//  IQKeyboardManager.swift
//  Beskar
//
//  Created by Igor on 22/03/2021.
//

import IQKeyboardManagerSwift

extension IQKeyboardManager {
    class func setUp() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 20.0
    }
}
