//
//  UserError.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 11.12.2022.
//

import Foundation

enum UserError {
    case notFilled
    case photoNotExist
    case cannotUnwrapToMuser
    case cannotGetUserInfo

}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Заполните все поля", comment: "")
        case .photoNotExist:
            return NSLocalizedString("Пользователь не выбрал фотографию", comment: "")
        case . cannotUnwrapToMuser:
            return NSLocalizedString("Невозможно конвертировать Muser из User", comment: "")
        case .cannotGetUserInfo:
            return NSLocalizedString("Невозможно загрузить информацию о User из Firebase", comment: "")
        }
    }
}
