//
//  SignUpViewController.swift
//  sChat
//
//  Created by Stanly Shiyanovskiy on 21.06.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public final class SignUpViewController: UIViewController {
    
    // MARK: - UI elements
    @IBOutlet private weak var welcomeLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var confirmPasswordLabel: UILabel!
    @IBOutlet private weak var alreadyOnboardLabel: UILabel!
    
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    
    @IBOutlet private weak var emailTextField: OneLineTextField!
    @IBOutlet private weak var passwordTextField: OneLineTextField!
    @IBOutlet private weak var confirmPasswordTextField: OneLineTextField!
    
    public weak var delegate: AuthNavigatingDelegate?

    public override func viewDidLoad() {
        super.viewDidLoad()

        configureButtons()
    }
    
    private func configureButtons() {
        signUpButton.configure(titleColor: .white, backgroundColor: .buttonDark())
        loginButton.configure(titleColor: .buttonRed(), backgroundColor: .clear)
    }
    
    // MARK: - Actions
    @IBAction private func signUpButtonTapped() {
        AuthService.shared.register(email: emailTextField.text, password: passwordTextField.text, confirmPassword: confirmPasswordTextField.text) { result in
            switch result {
            case .success(let user):
                self.showAlert(with: "Успешно!", and: "ВЫ зарегистрированы!") {
                    self.present(SetupProfileViewController(currentUser: user), animated: true)
                }
            case .failure(let error):
                self.showAlert(with: "Ошибка!", and: error.localizedDescription)
            }
        }
    }
    
    @IBAction private func loginButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.toLoginVC()
        }
    }
}
