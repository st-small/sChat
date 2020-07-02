//
//  SetupProfileViewController.swift
//  sChat
//
//  Created by Stanly Shiyanovskiy on 21.06.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import FirebaseAuth
import UIKit

public final class SetupProfileViewController: UIViewController {
    
    // MARK: - UI elements
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var goToChatsButton: UIButton!
    
    @IBOutlet private weak var fullNameTextField: UITextField!
    @IBOutlet private weak var aboutMeTextField: UITextField!
    @IBOutlet private weak var sexSegmentedControl: UISegmentedControl!
    
    private var currentUser: User? = nil
    
    public init(currentUser: User) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        if let username = currentUser?.displayName {
            fullNameTextField.text = username
        }
        
        if let photoURL = currentUser?.photoURL {
            avatarImage.sd_setImage(with: photoURL, completed: nil)
        }
        configureButtons()
    }
    
    private func configureButtons() {
        avatarImage.layer.borderWidth = 1
        avatarImage.layer.borderColor = UIColor.black.cgColor
        goToChatsButton.configure(titleColor: .white,
                                  backgroundColor: .buttonDark())
    }
    
    @IBAction private func avatarTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction private func goToChatsButtonTapped() {
        guard
            let uid = currentUser?.uid,
            let email = currentUser?.email else { return }
        let segmentIndex = sexSegmentedControl.selectedSegmentIndex
        FirestoreService.shared.saveProfileWith(
            id: uid,
            email: email,
            username: fullNameTextField.text,
            avatarImage: avatarImage?.image,
            description: aboutMeTextField.text,
            sex: sexSegmentedControl.titleForSegment(at: segmentIndex)) { result in
                switch result {
                case .success(let sUser):
                    self.showAlert(with: "Успешно!", and: "Данные сохранены!", completion: {
                        let tabBar = MainTabBarController(currentUser: sUser)
                        tabBar.modalPresentationStyle = .fullScreen
                        self.present(tabBar, animated: true)
                    })
                case .failure(let error):
                    self.showAlert(with: "Ошибка!", and: error.localizedDescription)
                }
        }
    }
}

// MARK: - UIImagePickerControllerDelegate
extension SetupProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        avatarImage.image = image
    }
}
