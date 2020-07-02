//
//  SMessage.swift
//  sChat
//
//  Created by Stanly Shiyanovskiy on 30.06.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit
import FirebaseFirestore
import MessageKit

public struct ImageItem: MediaItem {
    public let url: URL?
    public let image: UIImage?
    public let placeholderImage: UIImage
    public let size: CGSize
}

public struct SMessage: Hashable, MessageType {
   
    public let content: String
    public var sender: SenderType
    public var sentDate: Date
    public let id: String?
    
    public var image: UIImage? = nil
    public var downloadURL: URL? = nil
    
    public var messageId: String {
        return id ?? UUID().uuidString
    }
    
    public var kind: MessageKind {
        if let image = image {
            let mediaItem = ImageItem(url: nil, image: nil, placeholderImage: image, size: image.size)
            return .photo(mediaItem)
        } else {
            return .text(content)
        }
    }
    
    public init(user: SUser, content: String) {
        self.content = content
        sender = Sender(senderId: user.id, displayName: user.username)
        sentDate = Date()
        id = nil
    }
    
    public init(user: SUser, image: UIImage) {
        sender = Sender(senderId: user.id, displayName: user.username)
        self.image = image
        content = ""
        sentDate = Date()
        id = nil
    }
    
    public init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let sentDate = data["created"] as? Timestamp else { return nil }
        guard let senderId = data["senderID"] as? String else { return nil }
        guard let senderName = data["senderName"] as? String else { return nil }
        
        self.id = document.documentID
        self.sentDate = sentDate.dateValue()
        sender = Sender(senderId: senderId, displayName: senderName)
        
        if let content = data["content"] as? String {
            self.content = content
            downloadURL = nil
        } else if let urlString = data["url"] as? String, let url = URL(string: urlString) {
            downloadURL = url
            self.content = ""
        } else {
            return nil
        }
    }
    
    public var representation: [String: Any] {
        var rep: [String: Any] = [
            "created": sentDate,
            "senderID": sender.senderId,
            "senderName": sender.displayName
        ]
        
        if let url = downloadURL {
            rep["url"] = url.absoluteString
        } else {
            rep["content"] = content
        }
        
        return rep
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
    
    public static func == (lhs: SMessage, rhs: SMessage) -> Bool {
        return lhs.messageId == rhs.messageId
    }
}

extension SMessage: Comparable {
    public static func < (lhs: SMessage, rhs: SMessage) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
}
