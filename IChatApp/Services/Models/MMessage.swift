//
//  MMessage.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 12.12.2022.
//

import UIKit
import FirebaseFirestore


struct MMessage: Hashable {
    let content: String
    let senderId: String
    let senderUserName: String
    let sentDate: Date
    let id: String?
    
    init(user: MUser, content: String) {
        self.content = content
        senderId = user.id
        senderUserName = user.username
        sentDate = Date()
        id = nil
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let sentData = data["created"] as? Timestamp else { return nil }
        guard let senderId = data["senderID"] as? String else { return nil }
        guard let senderName = data["senderName"] as? String else { return nil }
        guard let content = data["content"] as? String else { return nil }
        
        self.id = document.documentID
        self.sentDate = sentData.dateValue()
        self.senderId = senderId
        self.senderUserName = senderName
        self.content = content
    }
    
    var representation: [String : Any] {
        let rep: [String : Any] = [
            "created": sentDate,
            "senderID": senderId,
            "senderName": senderUserName,
            "content": content
        ]
        return rep
    }
}
