//
//  Loader.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 15/07/2023.
//

import UIKit

open class Loader: UIView {
    static let shared = Loader()
    private var viewTag = 1234567890
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = progressBarColor.withAlphaComponent(0.1)
        tag = viewTag
        prepare()
        prepareLines()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        tag = viewTag
        backgroundColor = .systemGreen.withAlphaComponent(0.6)
        prepare()
        prepareLines()
    }
    
    private let firstProgressComponent = CAShapeLayer()
    private let secondProgressComponent = CAShapeLayer()
    private lazy var progressComponents = [firstProgressComponent, secondProgressComponent]
    var animationDuration: TimeInterval = 2
    var progressBarColor: UIColor = .appGreen
    
    var progressBarWidth: CGFloat = 3.0 {
        didSet {
            updateProgressBarWidth()
        }
    }
    
    lazy var minY: CGFloat = {
        return safeAreaInsets.top
    }() {
        didSet {
            updateLineLayers()
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        updateLineLayers()
    }
    
    private func prepare() {
        clipsToBounds = true
    }
    
    private func updateProgressBarWidth() {
        progressComponents.forEach {
            $0.lineWidth = progressBarWidth
        }
        updateLineLayers()
    }
    
    private func applyFirstComponentAnimations(to layer: CALayer) {
        let strokeEndAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.values = [0, 1]
        strokeEndAnimation.keyTimes = [0, NSNumber(value: 1.2 / animationDuration)]
        strokeEndAnimation.timingFunctions = [CAMediaTimingFunction(name: .easeOut),
                                              CAMediaTimingFunction(name: .easeOut)]

        let strokeStartAnimation = CAKeyframeAnimation(keyPath: "strokeStart")
        strokeStartAnimation.values = [0, 1.2]
        strokeStartAnimation.keyTimes = [NSNumber(value: 0.25 / animationDuration),
                                         NSNumber(value: 1.8 / animationDuration)]
        strokeStartAnimation.timingFunctions = [CAMediaTimingFunction(name: .easeIn),
                                                CAMediaTimingFunction(name: .easeIn)]

        [strokeEndAnimation, strokeStartAnimation].forEach {
            $0.duration = animationDuration
            $0.repeatCount = .infinity
            $0.isRemovedOnCompletion = false
        }

        layer.add(strokeEndAnimation, forKey: "firstComponentStrokeEnd")
        layer.add(strokeStartAnimation, forKey: "firstComponentStrokeStart")
    }

    private func applySecondComponentAnimations(to layer: CALayer) {
        let strokeEndAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.values = [0, 1.1]
        strokeEndAnimation.keyTimes = [NSNumber(value: 1.375 / animationDuration), 1]

        let strokeStartAnimation = CAKeyframeAnimation(keyPath: "strokeStart")
        strokeStartAnimation.values = [0, 1]
        strokeStartAnimation.keyTimes = [NSNumber(value: 1.825 / animationDuration), 1]

        [strokeEndAnimation, strokeStartAnimation].forEach {
            $0.timingFunctions = [CAMediaTimingFunction(name: .easeOut),
                                  CAMediaTimingFunction(name: .easeOut)]
            $0.duration = animationDuration
            $0.repeatCount = .infinity
            $0.isRemovedOnCompletion = false
        }

        layer.add(strokeEndAnimation, forKey: "secondComponentStrokeEnd")
        layer.add(strokeStartAnimation, forKey: "secondComponentStrokeStart")
    }
    
    func prepareLines() {
        progressComponents.forEach {
            $0.fillColor = progressBarColor.cgColor
            $0.lineWidth = progressBarWidth
            $0.strokeColor = progressBarColor.cgColor
            $0.strokeStart = 0
            $0.strokeEnd = 0
            layer.addSublayer($0)
        }
    }
    
    private func updateLineLayers() {
        frame = CGRect(x: frame.minX, y: minY, width: bounds.width, height: progressBarWidth)

        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: 0, y: bounds.midY))
        linePath.addLine(to: CGPoint(x: bounds.width, y: bounds.midY))

        progressComponents.forEach {
            $0.path = linePath.cgPath
            $0.frame = bounds
        }
    }
    
    public func startAnimating() {
        applyFirstComponentAnimations(to: firstProgressComponent)
        applySecondComponentAnimations(to: secondProgressComponent)
    }
    
    func forceBeginRefreshing() {
        startAnimating()
    }
    
    public func stopAnimating(completion: (() -> Void)? = nil) {
        removeProgressAnimations()
        completion?()
    }
    
    private func removeProgressAnimations() {
        progressComponents.forEach { $0.removeAllAnimations() }
    }
    
    static func forceRemoveAnimations() {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        if let view = window.viewWithTag(1234567890) {
            view.layer.removeAllAnimations()
            _ = (view.layer.sublayers ?? []).map{$0.removeFromSuperlayer()}
            view.removeFromSuperview()
        }
    }
    
    @discardableResult
    public class func showProgressBar(parentView: UIView, navBarHeight: CGFloat) -> UIView {
        let progressBar = Loader(frame: parentView.frame)
        progressBar.minY = navBarHeight
        parentView.addSubview(progressBar)
        
        progressBar.startAnimating()
        parentView.bringSubviewToFront(progressBar)
        return progressBar
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        updateLineLayers()
    }
    
}
