//
//  UILabel+.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import Foundation
import UIKit

extension UILabel {
    convenience init(
        text: String,
        font: UIFont = .systemFont(ofSize: 16),
        numberOfLines: Int = 1,
        color: UIColor = .label,
        alignment: NSTextAlignment = .center,
        adjustsFontSizeToFitWidth: Bool = true,
        underlined: Bool = false,
        huggingPriority: UILayoutPriority? = nil,
        huggingAxis: NSLayoutConstraint.Axis? = nil,
        lineBreakMode: NSLineBreakMode = .byWordWrapping
    ) {
        self.init(frame: .zero)
        self.text = text
        self.textColor = color
        self.font = font
        self.numberOfLines = numberOfLines
        self.textAlignment = alignment
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        if underlined {
            underline()
        }
        if let huggingPriority = huggingPriority, let huggingAxis = huggingAxis {
            setContentHuggingPriority(huggingPriority, for: huggingAxis)
        }
    }
    
    func underline() {
        let attr: NSMutableAttributedString =  NSMutableAttributedString(string: self.text ?? "")
        attr.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attr.length))
        attributedText = attr
        
    }
}
