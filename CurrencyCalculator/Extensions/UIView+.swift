//
//  UIView+.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 12/07/2023.
//

import UIKit

class UIViewTapGestureRecognizer: UITapGestureRecognizer {
    var action: VoidAction? = nil
}

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

extension UIView {
    
    @discardableResult
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        leading: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        trailing: NSLayoutXAxisAnchor? = nil,
        padding: UIEdgeInsets = .zero
    ) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        [
            anchoredConstraints.top,
            anchoredConstraints.leading,
            anchoredConstraints.bottom,
            anchoredConstraints.trailing,
            anchoredConstraints.width,
            anchoredConstraints.height
        ].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func centerXInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superViewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
        }
    }
    
    func centerYInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    
    func constraintWidth(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    @discardableResult func constraintHeight(constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let height = heightAnchor.constraint(equalToConstant: constant)
        height.isActive = true
        return height
    }
    
    func constraintSize(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func constraintSize(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func constraintSize(size: CGSize) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    
    @discardableResult func withRadius(_ constant: CGFloat) -> Self {
        cornerRadius = constant
        return self
    }
    
    @discardableResult func withHeight(_ constant: CGFloat) -> Self {
        constraintHeight(constant: constant)
        return self
    }
    
    @discardableResult func withWidth(_ constant: CGFloat) -> Self {
        constraintWidth(constant: constant)
        return self
    }
    
    @discardableResult func withSize(width: CGFloat, height: CGFloat) -> Self {
        constraintSize(height: height, width: width)
        return self
    }
    
    @discardableResult func withSize(_ size: CGFloat) -> Self {
        constraintSize(height: size, width: size)
        return self
    }
    
    @discardableResult func withSize(_ size: CGSize) -> Self {
        constraintSize(height: size.height, width: size.width)
        return self
    }
    
    func addRoundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func addTapGesture(action: @escaping () -> Void){
        let tap = UIViewTapGestureRecognizer(target: self , action: #selector(self.handleTap(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    @objc func handleTap(_ sender: UIViewTapGestureRecognizer) {
        sender.action?()
    }
    
    func enableUserInteraction(_ enable: Bool = true, alpha: CGFloat = 1) {
        isUserInteractionEnabled = enable
        self.alpha = alpha
    }
    
    func breathe(
        scaleX: CGFloat = 1.2,
        scaleY: CGFloat = 1.2,
        duration: Double = 0.7,
        options: UIView.AnimationOptions = [.autoreverse, .repeat, .allowUserInteraction],
        completion: VoidAction?
    ) {
        UIView.animate(withDuration: duration, delay: 0, options: options) {
            self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        } completion: { _ in
            completion?()
        }
    }
    
    func stopBreathing() {
        UIView.animate(withDuration: 0.5 ) {
            self.transform = CGAffineTransform.identity
        }
    }
    
    func onclickAnimation(scaleX: CGFloat = 0.94, scaleY: CGFloat = 1, duration: Double = 0.1) {
        breathe(scaleX: scaleX, scaleY: scaleY, duration: duration, options: []) { [weak self] in
            guard let self = self else { return }
            self.stopBreathing()
        }
    }
    
    func animateOnTap(completion: VoidAction? = nil) {
        addTapGesture {
            self.onclickAnimation()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.15) {
                completion?()
            }
        }
    }
    
    func applyShadow(radius: CGFloat = 5) {
        layer.shadowColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.09).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = radius
        layer.shadowOffset = .init(width: 0, height: radius)
        
    }
}

extension UIEdgeInsets {
    static public func _init(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> UIEdgeInsets {
        .init(top: top, left: left, bottom: bottom, right: right)
    }
    
    static public func _init(allEdges: CGFloat = 0) -> UIEdgeInsets {
        .init(top: allEdges, left: allEdges, bottom: allEdges, right: allEdges)
    }
    
    static public func _init(topBottom: CGFloat = 0, leftRight: CGFloat = 0) -> UIEdgeInsets {
        .init(top: topBottom, left: leftRight, bottom: topBottom, right: leftRight)
    }
}
