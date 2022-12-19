//
//  TableSection.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 17.12.2022.
//

import UIKit

struct TableSection {
    let title: String?
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(model: StaticCellOptions)
}

struct StaticCellOptions {
    let content: String?
    let icon: UIImage?
    let iconBackgroundColor: UIColor
}
