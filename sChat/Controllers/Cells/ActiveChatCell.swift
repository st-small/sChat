//
//  ActiveChatCell.swift
//  sChat
//
//  Created by Stanly Shiyanovskiy on 21.06.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public final class ActiveChatCell: UICollectionViewCell, SelfConfiguringCell {
    
    // MARK: - UI elements
    @IBOutlet private weak var friendImage: UIImageView!
    @IBOutlet private weak var friendName: UILabel!
    @IBOutlet private weak var lastMessage: UILabel!
    @IBOutlet private weak var gradient: GradientView!
    
    public static var reuseId: String = "ActiveChatCell"
    
    public func configure<U>(model value: U) where U : Hashable {
        guard let model: SChat = value as? SChat else { return }
        friendName.text = model.friendUsername
        lastMessage.text = model.lastMessageContent
        friendImage.sd_setImage(with: URL(string: model.friendAvatarStringURL), completed: nil)
        
        gradient.setupGradient(from: .topTrailing, to: .bottomLeading, startColor: #colorLiteral(red: 0.7882352941, green: 0.631372549, blue: 0.9411764706, alpha: 1), endColor: #colorLiteral(red: 0.4784313725, green: 0.6980392157, blue: 0.9215686275, alpha: 1))
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
}
