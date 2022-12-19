//
//  MChat.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 08.12.2022.
//

import UIKit
import FirebaseFirestore

struct MChat: Hashable, Decodable {
    var friendFirstName: String
    var frientSecondName: String
    var friendAvatarStringURL: String
    var lastMessageContent: String
    var friendId: String
    
    var representation: [String : Any] {
        var rep = ["friendFirstName": friendFirstName]
        rep["frientSecondName"] = frientSecondName
        rep["friendAvatarStringURL"] = friendAvatarStringURL
        rep["lastMessage"] = lastMessageContent
        rep["friendId"] = friendId
        return rep
    }
    
    init(friendFirstName: String, frientSecondName: String, friendAvatarStringURL: String, friendId: String, lastMessageContent: String) {
        self.friendFirstName = friendFirstName
        self.frientSecondName = frientSecondName
        self.friendAvatarStringURL = friendAvatarStringURL
        self.friendId = friendId
        self.lastMessageContent = lastMessageContent
    }
    
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let friendFirstName = data["friendFirstName"] as? String,
        let frientSecondName = data["frientSecondName"] as? String,
        let friendAvatarStringURL = data["friendAvatarStringURL"] as? String,
        let friendId = data["friendId"] as? String,
        let lastMessageContent = data["lastMessage"] as? String else { return nil }
        
        self.friendFirstName = friendFirstName
        self.frientSecondName = frientSecondName
        self.friendAvatarStringURL = friendAvatarStringURL
        self.friendId = friendId
        self.lastMessageContent = lastMessageContent
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.friendId == rhs.friendId
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        let lowercasedFilter = filter.lowercased()
        let fullName = "\(friendFirstName) \(frientSecondName)"
        return fullName.lowercased().contains(lowercasedFilter)
    }
}
