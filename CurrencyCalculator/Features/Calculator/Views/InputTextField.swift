//
//  InputTextField.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import UIKit

final class InputTextField: UIView {
    
    private let textField = UITextField()
    private let rightLabel = UILabel(
        text: "EUR",
        font: .systemFont(ofSize: 16, weight: .bold),
        color: .secondaryLabel,
        huggingPriority: .required,
        huggingAxis: .horizontal
    )
    private lazy var inputStackView = UIHStack(subviews: [textField, rightLabel], spacing: 10)
    
    var rightText: String {
        get { rightLabel.text ?? "" }
        set { rightLabel.text = newValue }
    }
    
    var text: String {
        get { textField.text ?? "" }
        set { textField.text = newValue }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .secondarySystemBackground
        cornerRadius = 5
        with(inputStackView) {
            addSubview($0)
            $0.centerYInSuperview()
            $0.anchor(leading: leadingAnchor,
                      trailing: trailingAnchor,
                      padding: ._init(leftRight: 15))
        }
        textField.placeholder = "0.00"
    }
}
