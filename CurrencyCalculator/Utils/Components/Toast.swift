//
//  Toast.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import Foundation
import UIKit

enum ToastType {
    case success, error
}

class Toast: UIView {
    
    static var shared = Toast()
    
    let titleLabel = UILabel(text: "Test", numberOfLines: 0, color: .white, alignment: .left)
    
    var type: ToastType = .success {
        didSet {
            switch type {
            case .error:
                backgroundColor = .red
            case .success:
                backgroundColor = .systemGreen
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.anchor(top: safeAreaLayoutGuide.topAnchor,
                          leading: leadingAnchor,
                          bottom: bottomAnchor,
                          trailing: trailingAnchor,
                          padding: .init(top: 3, left: 20, bottom: 0, right: 5))
        self.isUserInteractionEnabled = true
        titleLabel.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToast)))
        titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToast)))
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        applyShadow()
    }
    
    @objc func didTapToast() {
        generateHapticFeedback()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            self.transform = .init(scaleX: 0.95, y: 0.95)
            UIView.animate(withDuration: 0.4, delay: 0.3, options: [], animations: {
                self.transform = .identity
                self.beginHideToast()
            }, completion: nil)
        })
        
    }
    
    func hideToast() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.beginHideToast()
        }
    }
    
    private func beginHideToast() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [], animations: {
            self.transform = .init(translationX: 0, y: -200)
        }, completion: nil)
    }
    
    func show(_ title: String, type: ToastType = .success) {
        generateHapticFeedback()
        
        self.type = type
        self.titleLabel.text = title
        
        guard let window = UIApplication.shared.keyWindow else { return }
        
        window.addSubview(self)
        window.bringSubviewToFront(self)
        
        self.constraintHeight(constant: notchHeight + 50)
        
        self.anchor(top: window.topAnchor, leading: window.leadingAnchor, bottom: nil, trailing: window.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        self.transform = .init(translationX: 0, y: -200)
        
        UIView.animate(withDuration: 0.7, delay: 0, options: [], animations: {
            self.transform = .identity
        }, completion: nil)
        
        hideToast()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
