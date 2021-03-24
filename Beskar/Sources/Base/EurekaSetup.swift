//
//  EurekaSetup.swift
//  Beskar
//
//  Created by Igor on 23/03/2021.
//

import BeskarUI
import Eureka

/// Eureka
/// This class holds the static func to setup the style for the Eureka forms
struct Eureka {

    // MARK: Public Static SetUp

    static func setUp() {

        // Switch Row

        SwitchRow.defaultCellSetup = { cell, _ in
            titleLabelSetup(cell.textLabel)
            detailLabelSetup(cell.detailTextLabel)
        }

        SwitchRow.defaultCellUpdate = { cell, _ in
            titleLabelUpdate(cell.textLabel)
            detailLabelUpdate(cell.detailTextLabel)
        }

        // Int Row

        IntRow.defaultCellSetup = { cell, _ in
            titleLabelSetup(cell.titleLabel)
            detailLabelSetup(cell.detailTextLabel)
        }

        IntRow.defaultCellUpdate = { cell, _ in
            titleLabelUpdate(cell.textLabel)
            detailLabelUpdate(cell.detailTextLabel)
        }

        // Text Row

        TextRow.defaultCellSetup = { cell, _ in
            detailLabelSetup(cell.textLabel)
        }

        TextRow.defaultCellUpdate = { cell, _ in
            detailLabelUpdate(cell.textLabel)
        }
    }

    // MARK: Private Static Methods

    private static let titleLabelSetup: ((UILabel?) -> Void) = { label in
        label?.font = UIFont.beskar.build(.typeExtraSmall)
    }

    private static let detailLabelSetup: ((UILabel?) -> Void) = { label in
        label?.font = UIFont.beskar.build(.extraSmall)
        label?.numberOfLines = 0
    }

    private static let titleLabelUpdate: ((UILabel?) -> Void) = { label in
        label?.textColor = UIColor.beskar.primary
    }

    private static let detailLabelUpdate: ((UILabel?) -> Void) = { label in
        label?.textColor = UIColor.beskar.secondary
    }
}
