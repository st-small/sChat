//
//  AuthViewController.swift
//  sChat
//
//  Created by Stanly Shiyanovskiy on 21.06.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import GoogleSignIn
import UIKit

public final class AuthViewController: UIViewController {
    
    // MARK: - UI elements
    @IBOutlet private weak var googleView: ButtonFormView!
    @IBOutlet private weak var emailView: ButtonFormView!
    @IBOutlet private weak var loginView: ButtonFormView!
    
    // MARK: - Data
    private let signUpVC = SignUpViewController()
    private let loginVC = LoginViewController()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonForms()
        
        signUpVC.delegate = self
        loginVC.delegate = self
        
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    private func configureButtonForms() {
        googleView.configure(type: .google, title: "Get started with", buttonTitle: "Google", delegate: self)
        emailView.configure(type: .black, title: "Or sign up with", buttonTitle: "Email", delegate: self)
        loginView.configure(type: .redTitle, title: "Alerady onboard?", buttonTitle: "Login", delegate: self)
    }
    
    // MARK: - Actions
    private func googleButtonTapped() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    private func emailButtonTapped() {
        present(signUpVC, animated: true)
    }
    
    private func loginButtonTapped() {
        present(loginVC, animated: true)
    }
}

extension AuthViewController: ButtonFormViewDelegate {
    public func buttonTapped(type: UIButtonType) {
        switch type {
        case .normal: break
        case .black: emailButtonTapped()
        case .redTitle: loginButtonTapped()
        case .google: googleButtonTapped()
        }
    }
}

extension AuthViewController: AuthNavigatingDelegate {
    public func toLoginVC() {
        present(loginVC, animated: true, completion: nil)
    }
    
    public func toSignUpVC() {
        present(signUpVC, animated: true, completion: nil)
    }
}

// MARK: - GIDSignInDelegate
extension AuthViewController: GIDSignInDelegate {
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        AuthService.shared.googleLogin(user: user, error: error) { (result) in
            switch result {
            case .success(let user):
                FirestoreService.shared.getUserData(user: user) { (result) in
                    switch result {
                    case .success(let sUser):
                        UIApplication.getTopViewController()?.showAlert(with: "Успешно", and: "Вы авторизованы") {
                            let mainTabBar = MainTabBarController(currentUser: sUser)
                            mainTabBar.modalPresentationStyle = .fullScreen
                            UIApplication.getTopViewController()?.present(mainTabBar, animated: true, completion: nil)
                        }
                    case .failure:
                        UIApplication.getTopViewController()?.showAlert(with: "Успешно", and: "Вы зарегистрированы") {
                            UIApplication.getTopViewController()?.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
                        }
                    } // result
                }
            case .failure(let error):
                self.showAlert(with: "Ошибка", and: error.localizedDescription)
            }
        }
    }
}
