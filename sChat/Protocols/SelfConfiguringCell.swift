//
//  SelfConfiguringCell.swift
//  sChat
//
//  Created by Stanly Shiyanovskiy on 23.06.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation

public protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure<U: Hashable>(model: U)
}

