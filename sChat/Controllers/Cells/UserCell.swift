//
//  UserCell.swift
//  sChat
//
//  Created by Stanly Shiyanovskiy on 23.06.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import SDWebImage
import UIKit

public final class UserCell: UICollectionViewCell, SelfConfiguringCell {

    // MARK: - UI elements
    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet private weak var userName: UILabel!
    @IBOutlet private weak var container: UIView!
    
    public static var reuseId: String = "UserCell"
    
    public func configure<U>(model value: U) where U : Hashable {
        guard let model: SUser = value as? SUser else { return }
        userName.text = model.username
        
        guard let url = URL(string: model.avatarStringURL) else { return }
        userImage.sd_setImage(with: url, completed: nil)
    }
    
    public override func layoutSubviews() {
        
        layer.cornerRadius = 4
        
        layer.shadowColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 4)
        clipsToBounds = false

        container.layer.cornerRadius = 4
        container.clipsToBounds = true
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        userImage.image = nil
    }
}
