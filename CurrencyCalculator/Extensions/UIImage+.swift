//
//  UIImage+.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import UIKit

extension UIImage {
    static var flag = UIImage(systemName: "flag.checkered.circle.fill")?.withTintColor(.appBlue) ?? UIImage()
    static var chevronDown = UIImage(systemName: "chevron.down") ?? UIImage()
    static var menu = UIImage(systemName: "text.justify.left")?.withTintColor(.systemGreen) ?? UIImage()
    static var arrowLeftRight = UIImage(systemName: "arrow.left.arrow.right") ?? UIImage()
    static var info = UIImage(systemName: "info.circle.fill") ?? UIImage()
    static var euro = UIImage(named: "eu") ?? UIImage()
}
