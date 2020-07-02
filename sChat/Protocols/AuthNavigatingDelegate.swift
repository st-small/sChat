//
//  AuthNavigatingDelegate.swift
//  sChat
//
//  Created by Stanly Shiyanovskiy on 25.06.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation

public protocol AuthNavigatingDelegate: class {
    func toLoginVC()
    func toSignUpVC()
}
