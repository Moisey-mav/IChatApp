//
//  SelfConfigureCell.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 08.12.2022.
//

import Foundation

protocol SelfConfigureCell {
    static var identifier: String { get }
    func configure<U: Hashable>(with value: U)
}
