//
//  UIImageView+.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import UIKit

extension UIImageView {
    convenience init(
        image: UIImage? = nil,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        tintColor: UIColor? = nil,
        size: CGFloat? = nil,
        height: CGFloat? = nil,
        width: CGFloat? = nil,
        cornerRadius: CGFloat? = nil,
        backgroundColor: UIColor? = nil
    ) {
        self.init(image: image)
        
        if let tintColor = tintColor {
            self.tintColor = tintColor
        }
        
        self.contentMode = contentMode
        
        if let size = size {
            constraintSize(constant: size)
        }
        
        if let height = height {
            constraintHeight(constant: height)
        }
        
        if let width = width {
            constraintWidth(constant: width)
        }
        
        if let cornerRadius = cornerRadius {
            self.cornerRadius = cornerRadius
        }
        
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
    }
}

