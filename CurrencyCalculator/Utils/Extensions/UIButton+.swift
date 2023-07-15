//
//  UIButton+.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import UIKit

extension UIButton {
    convenience init(
        title: String,
        font: UIFont = .systemFont(ofSize: 15),
        textColor: UIColor = .label,
        backgroundColor: UIColor = .clear,
        cornerRadius: CGFloat = 5,
        height: CGFloat? = nil,
        width: CGFloat? = nil,
        borderWidth: CGFloat? = nil,
        borderColor: UIColor? = nil,
        isEnabled: Bool = true
    ) {
        self.init()
        self.title = title
        self.font = font
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.cornerRadius = cornerRadius
        self.enable(isEnabled)
        
        if let height = height {
            self.constraintHeight(constant: height)
        }
        
        if let width = width {
            self.constraintWidth(constant: width)
        }
    }
    
    var title: String? {
        get { title(for: .normal) }
        set { setTitle(newValue, for: .normal) }
    }
    
    var attributedTitle: NSAttributedString? {
        get { attributedTitle(for: .normal) }
        set { setAttributedTitle(newValue, for: .normal) }
    }
    
    var textColor: UIColor? {
        get { self.titleColor(for: .normal) }
        set { self.setTitleColor(newValue, for: .normal) }
    }
    
    func enable(_ enable: Bool = true) {
        enableUserInteraction(enable)
        alpha = enable ? 1 : 0.7
    }
    
    var font: UIFont? {
        get { titleLabel?.font }
        set { titleLabel?.font = newValue }
    }
}
