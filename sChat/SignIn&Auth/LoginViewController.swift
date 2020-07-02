//
//  LoginViewController.swift
//  sChat
//
//  Created by Stanly Shiyanovskiy on 21.06.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import GoogleSignIn
import UIKit

public final class LoginViewController: UIViewController {
    
    // MARK: - UI elements
    @IBOutlet private weak var googleView: ButtonFormView!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var signInButton: UIButton!
    
    @IBOutlet private weak var emailTextField: OneLineTextField!
    @IBOutlet private weak var passwordTextField: OneLineTextField!
    
    public weak var delegate: AuthNavigatingDelegate?

    public override func viewDidLoad() {
        super.viewDidLoad()

        configureButtons()
    }
    
    private func configureButtons() {
        googleView.configure(type: .google,
                             title: "Login with",
                             buttonTitle: "Google",
                             delegate: self)
        loginButton.configure(titleColor: .white,
                              backgroundColor: .buttonDark())
        signInButton.configure(titleColor: .buttonRed(),
                               backgroundColor: .clear)
    }
    
    // MARK: - Actions
    private func googleButtonTapped() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction private func signUpButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.toSignUpVC()
        }
    }
    
    @IBAction private func loginButtonTapped() {
        AuthService.shared.login(email: emailTextField.text, password: passwordTextField.text) { result in
            switch result {
            case .success(let user):
                self.showAlert(with: "Успешно!", and: "Вы авторизованы!") {
                    FirestoreService.shared.getUserData(user: user) { (result) in
                        switch result {
                        case .success(let sUser):
                            let tabBar = MainTabBarController(currentUser: sUser)
                            tabBar.modalPresentationStyle = .fullScreen
                            self.present(tabBar, animated: true)
                        case .failure(_):
                            let profile = SetupProfileViewController(currentUser: user)
                            self.present(profile, animated: true, completion: nil)
                        }
                    }
                }
            case .failure(let error):
                self.showAlert(with: "Ошибка!", and: error.localizedDescription)
            }
        }
    }
}

extension LoginViewController: ButtonFormViewDelegate {
    public func buttonTapped(type: UIButtonType) {
        switch type {
        case .normal: break
        case .black: break
        case .redTitle: break
        case .google: googleButtonTapped()
        }
    }
}
