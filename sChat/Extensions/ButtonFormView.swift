//
//  ButtonFormView.swift
//  sChat
//
//  Created by Stanly Shiyanovskiy on 21.06.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol ButtonFormViewDelegate: class {
    func buttonTapped(type: UIButtonType)
}

public final class ButtonFormView: UIView {
    
    // MARK: - UI elements
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var button: UIButton!
    
    // MARK: - Data
    private var delegate: ButtonFormViewDelegate?
    private var buttonType: UIButtonType = .normal
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        let xibView = loadViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
    }
    
    private func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ButtonFormView", bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }
    
    public func configure(type: UIButtonType,
                          title: String,
                          buttonTitle: String,
                          delegate: ButtonFormViewDelegate) {
        label.text = title
        button.setTitle(buttonTitle, for: .normal)
        
        switch type {
        case .normal:
            button.configure(titleColor: .black,
                             backgroundColor: .white,
                             isShadow: true)
        case .black:
            button.configure(titleColor: .white,
                             backgroundColor: .buttonDark())
        case .redTitle:
            button.configure(titleColor: .buttonRed(),
                             backgroundColor: .white,
                             isShadow: true)
        case .google:
            button.configure(titleColor: .black,
                             backgroundColor: .white,
                             isShadow: true)
            button.customizeGoogleButton()
        }
        
        self.delegate = delegate
        buttonType = type
    }
    
    // MARK: - Actions
    @IBAction private func buttonTapped() {
        delegate?.buttonTapped(type: buttonType)
    }
}
