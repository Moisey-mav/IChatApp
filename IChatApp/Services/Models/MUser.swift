//
//  MUser.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 08.12.2022.
//

import UIKit
import FirebaseFirestore

struct MUser: Hashable, Decodable {
    var firstName: String
    var secondName: String
    var email: String
    var avatarStringURL: String
    var description: String
    var sex: String
    var id: String
    
    init(firstName: String, secondName: String, email: String, avatarStringURL: String, description: String, sex: String, id: String) {
        self.firstName = firstName
        self.secondName = secondName
        self.email = email
        self.avatarStringURL = avatarStringURL
        self.description = description
        self.sex = sex
        self.id = id
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil}
        guard let firstName = data["firstName"] as? String,
        let secondName = data["secondName"] as? String,
        let email = data["email"] as? String,
        let avatarStringURL = data["avatarStringURL"] as? String,
        let description = data["description"] as? String,
        let sex = data["sex"] as? String,
        let id = data["uid"] as? String else { return nil }
        
        self.firstName = firstName
        self.secondName = secondName
        self.email = email
        self.avatarStringURL = avatarStringURL
        self.description = description
        self.sex = sex
        self.id = id
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let firstName = data["firstName"] as? String,
        let secondName = data["secondName"] as? String,
        let email = data["email"] as? String,
        let avatarStringURL = data["avatarStringURL"] as? String,
        let description = data["description"] as? String,
        let sex = data["sex"] as? String,
        let id = data["uid"] as? String else { return nil }
        
        self.firstName = firstName
        self.secondName = secondName
        self.email = email
        self.avatarStringURL = avatarStringURL
        self.description = description
        self.sex = sex
        self.id = id
    }
    
    var representation: [String: Any] {
        var rep = ["firstName": firstName]
        rep["secondName"] = secondName
        rep["email"] = email
        rep["avatarStringURL"] = avatarStringURL
        rep["description"] = description
        rep["sex"] = sex
        rep["uid"] = id
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MUser, rhs: MUser) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        let lowercasedFilter = filter.lowercased()
        let fullName = "\(firstName) \(secondName)"
        return fullName.lowercased().contains(lowercasedFilter)
    }
}
