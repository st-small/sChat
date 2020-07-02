//
//  SChat.swift
//  sChat
//
//  Created by Stanly Shiyanovskiy on 23.06.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import FirebaseFirestore
import Foundation

public struct SChat: Hashable, Codable {
    public let friendId: String
    public let friendUsername: String
    public let friendAvatarStringURL: String
    public let lastMessageContent: String
    
    public var representation: [String : Any] {
        var rep = ["friendUsername": friendUsername]
        rep["friendAvatarStringURL"] = friendAvatarStringURL
        rep["friendId"] = friendId
        rep["lastMessage"] = lastMessageContent
        return rep
    }
    
    public init(friendUsername: String, friendAvatarStringURL: String, friendId: String, lastMessageContent: String) {
        self.friendUsername = friendUsername
        self.friendAvatarStringURL = friendAvatarStringURL
        self.friendId = friendId
        self.lastMessageContent = lastMessageContent
    }
    
    public init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let friendUsername = data["friendUsername"] as? String,
        let friendAvatarStringURL = data["friendAvatarStringURL"] as? String,
        let friendId = data["friendId"] as? String,
        let lastMessageContent = data["lastMessage"] as? String else { return nil }
        
        self.friendUsername = friendUsername
        self.friendAvatarStringURL = friendAvatarStringURL
        self.friendId = friendId
        self.lastMessageContent = lastMessageContent
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    
    public static func == (lhs: SChat, rhs: SChat) -> Bool {
        return lhs.friendId == rhs.friendId
    }
}
