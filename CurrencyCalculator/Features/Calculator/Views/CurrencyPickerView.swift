//
//  CurrencyPickerView.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import UIKit

final class CurrencyPickerView: UIView {
    
    private let currencyLabel = UILabel(text: "EUR")
    private let flagImageView = UIImageView(image: .flag, tintColor: .appBlue, size: 25, cornerRadius: 12.5)
    private let dropdownImageView = UIImageView(image: .chevronDown, size: 18)
    private lazy var contentStackView = UIHStack(
        subviews: [flagImageView, currencyLabel, dropdownImageView],
        spacing: 8,
        alignment: .center
    )
    
    var flag: UIImage? {
        get { flagImageView.image }
        set { flagImageView.image = newValue }
    }
    
    var text: String {
        get { currencyLabel.text ?? "" }
        set { currencyLabel.text = newValue }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        borderColor = .tertiaryLabel
        borderWidth = 0.7
        cornerRadius = 5
        with(contentStackView) {
            addSubview($0)
            $0.centerYInSuperview()
            $0.anchor(leading: leadingAnchor,
                      trailing: trailingAnchor,
                      padding: ._init(leftRight: 12))
        }
    }

}
