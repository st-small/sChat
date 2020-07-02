//
//  ChatRequestViewController.swift
//  sChat
//
//  Created by Stanly Shiyanovskiy on 24.06.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public final class ChatRequestViewController: UIViewController {
    
    // MARK: - UI elements
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var aboutMeLabel: UILabel!
    @IBOutlet private weak var acceptButton: UIButton!
    @IBOutlet private weak var denyButton: UIButton!
    
    public weak var delegate: WaitingChatsNavigation?
    private var chat: SChat
    
    public init(chat: SChat) {
        self.chat = chat
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = chat.friendUsername
        imageView.sd_setImage(with: URL(string: chat.friendAvatarStringURL), completed: nil)
        
        acceptButton.configure(titleColor: .white, backgroundColor: .black, font: .laoSangamMN20(), isShadow: false, cornerRadius: 10)
        acceptButton.applyGradients(cornerRadius: 10)
        
        denyButton.configure(titleColor: #colorLiteral(red: 0.8352941176, green: 0.2, blue: 0.2, alpha: 1), backgroundColor: .mainWhite(), font: .laoSangamMN20(), isShadow: false, cornerRadius: 10)
        denyButton.layer.borderWidth = 1.2
        denyButton.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0.2, blue: 0.2, alpha: 1)
    }
    
    // MARK: - Actions
    @IBAction private func denyButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.removeWaitingChat(chat: self.chat)
        }
    }
    
    @IBAction private func acceptButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.changeToActive(chat: self.chat)
        }
    }
}
