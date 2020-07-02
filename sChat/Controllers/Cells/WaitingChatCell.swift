//
//  WaitingChatCell.swift
//  sChat
//
//  Created by Stanly Shiyanovskiy on 23.06.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public final class WaitingChatCell: UICollectionViewCell, SelfConfiguringCell {

    // MARK: - UI elements
    @IBOutlet private weak var friendImage: UIImageView!
    
    public static var reuseId: String = "WaitingChatCell"
    
    public func configure<U>(model value: U) where U : Hashable {
        guard let model: SChat = value as? SChat else { return }
        friendImage.sd_setImage(with: URL(string: model.friendAvatarStringURL), completed: nil)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
}
