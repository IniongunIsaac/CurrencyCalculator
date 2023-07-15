//
//  UIViewController+.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import Foundation
import UIKit

extension UIViewController {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func addSubview(_ view: UIView) {
        self.view.addSubview(view)
    }
    
    var topAnchor: NSLayoutYAxisAnchor? { view.topAnchor }
    
    var bottomAnchor: NSLayoutYAxisAnchor? { view.bottomAnchor }
    
    var leadingAnchor: NSLayoutXAxisAnchor? { view.leadingAnchor }
    
    var trailingAnchor: NSLayoutXAxisAnchor? { view.trailingAnchor }
    
    var safeAreaTopAnchor: NSLayoutYAxisAnchor? { view.safeAreaLayoutGuide.topAnchor }
    
    var safeAreaBottomAnchor: NSLayoutYAxisAnchor? { view.safeAreaLayoutGuide.bottomAnchor }
    
    var safeAreaLeadingAnchor: NSLayoutXAxisAnchor? { view.safeAreaLayoutGuide.leadingAnchor }
    
    var safeAreaTrailingAnchor: NSLayoutXAxisAnchor? { view.safeAreaLayoutGuide.trailingAnchor }
    
    var backgroundColor: UIColor? {
        get { view.backgroundColor }
        set { view.backgroundColor = newValue }
    }
    
    func showMessage(_ message: String, type: ToastType = .success) {
        Toast.shared.show(message, type: type)
    }
    
    func hideAlert() {
        Toast.shared.hideToast()
    }
    
    var safeAreaTopHeight: CGFloat {
        view.safeAreaInsets.top
    }
    
    func showLoader(_ show: Bool, interactionEnabled: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            Loader.forceRemoveAnimations()
            if show {
                Loader.showProgressBar(
                    parentView: self.view,
                    navBarHeight: self.safeAreaTopHeight
                )
            } else {
                Loader.forceRemoveAnimations()
            }
            
            self.interactionEnabled(interactionEnabled)
        }
    }
    
    func interactionEnabled(_ enabled: Bool) {
        let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        guard let currentWindow: UIWindow =  window else {return}
        currentWindow.isUserInteractionEnabled = enabled
    }
}
