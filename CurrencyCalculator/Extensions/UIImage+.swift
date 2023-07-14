//
//  UIImage+.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import UIKit

extension UIImage {
    static var flag = UIImage(systemName: "flag.checkered.circle.fill")?.withTintColor(.systemBlue) ?? UIImage()
    static var chevronDown = UIImage(systemName: "chevron.down") ?? UIImage()
    static var menu = UIImage(systemName: "text.justify.left")?.withTintColor(.systemGreen) ?? UIImage()
}
