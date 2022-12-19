//
//  Validators.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 10.12.2022.
//

import Foundation

class Validators {
    
    static func isFilled(email: String?, password: String?, confirmPassword: String?) -> Bool {
        guard let password = password,
              let confirmPassword = confirmPassword,
              let email = email,
              password != "",
              confirmPassword != "",
              email != "" else {
            return false
        }
        return true
    }
    
    static func isFilled(firstName: String?, secondName: String?, desctiption: String?, sex: String?) -> Bool {
        guard let firstName = firstName,
              let secondName = secondName,
              let desctiption = desctiption,
              let sex = sex,
              firstName != "",
              secondName != "",
              desctiption != "",
              sex != "" else {
            return false
        }
        return true
    }
    
    static func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return chek(text: email, regEx: emailRegEx)
    }
    
    private static func chek(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
    
}
