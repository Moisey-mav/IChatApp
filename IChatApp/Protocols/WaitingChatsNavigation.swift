//
//  WaitingChatsNavigation.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 12.12.2022.
//

import Foundation

protocol WaitingChatsNavigation: AnyObject {
    func remoweWaitingChat(chat: MChat)
    func changeToActive(chat: MChat)
}
