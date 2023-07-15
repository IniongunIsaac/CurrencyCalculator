//
//  UIScrollView+.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 12/07/2023.
//

import UIKit

extension UIScrollView {
    convenience init(
        children: [UIView],
        showsVerticalScrollIndicator: Bool = false,
        showsHorizontalScrollIndicator: Bool = false
    ) {
        self.init(frame: .zero)
        addSubviews(children)
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        self.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
    }
    
    func updateContentView(_ offset: CGFloat = 50) {
        contentSize.height = (subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height) + offset
    }
    
    func offsetContent(
        top: CGFloat = 30,
        bottom: CGFloat = 40,
        contentOffset: CGPoint = CGPoint(x: 0, y: -30),
        animated: Bool = true
    ) {
        contentInset.top = top
        contentInset.bottom = bottom
        setContentOffset(contentOffset, animated: animated)
    }
    
    func showIndicators(_ show: Bool = true) {
        showsVerticalScrollIndicator = show
        showsHorizontalScrollIndicator = show
    }
    
    var _topAnchor: NSLayoutYAxisAnchor? { contentLayoutGuide.topAnchor }
    
    var _bottomAnchor: NSLayoutYAxisAnchor? { contentLayoutGuide.bottomAnchor }
    
    var _leadingAnchor: NSLayoutXAxisAnchor? { frameLayoutGuide.leadingAnchor }
    
    var _trailingAnchor: NSLayoutXAxisAnchor? { frameLayoutGuide.trailingAnchor }
    
}
