//
//  AuthNavigationDelegate.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 10.12.2022.
//

import Foundation

protocol AuthNavigationDelegate: AnyObject {
    func toLoginVC()
    func toSignUpVC()
}
