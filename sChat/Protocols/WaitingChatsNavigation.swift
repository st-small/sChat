//
//  WaitingChatsNavigation.swift
//  sChat
//
//  Created by Stanly Shiyanovskiy on 30.06.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation

public protocol WaitingChatsNavigation: class {
    func removeWaitingChat(chat: SChat)
    func changeToActive(chat: SChat)
}
