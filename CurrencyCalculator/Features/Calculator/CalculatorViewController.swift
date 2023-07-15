//
//  CalculatorViewController.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import UIKit

final class CalculatorViewController: UIViewController {
    
    @Provided var viewModel: CalculatorViewModelProtocol
    
    lazy var menuBarButton = UIBarButtonItem(image: .menu, style: .plain, target: self, action: #selector(didTapMenuButton))
    let signupButton = UIButton(title: "Sign up", textColor: .systemGreen)
    lazy var signupBarButton = UIBarButtonItem(title: "Sign up", style: .plain, target: self, action: #selector(didTapSignupButton))
    let headerLabel = UILabel(
        text: "Currency\nCalcultor.",
        font: .systemFont(ofSize: 35, weight: .black),
        numberOfLines: 0,
        color: .appBlue,
        alignment: .left
    )
    let euroInputTextField = InputTextField().withHeight(45)
    let newCurrencyInputTextField = InputTextField().withHeight(45)
    let euroPickerView = CurrencyPickerView().withHeight(50)
    let leftRightImageView = UIImageView(image: .arrowLeftRight, width: 40)
    let newCurrencyPickerView = CurrencyPickerView().withHeight(50)
    private lazy var pickerStackView = UIHStack(
        subviews: [euroPickerView, leftRightImageView, newCurrencyPickerView],
        spacing: 10,
        alignment: .center
    )
    let convertButton = UIButton(
        title: "Convert",
        font: .systemFont(ofSize: 16, weight: .semibold),
        textColor: .white,
        backgroundColor: .appGreen,
        cornerRadius: 5,
        height: 50
    )
    private lazy var contentStackView = UIVStack(
        subviews: [headerLabel, euroInputTextField, newCurrencyInputTextField, pickerStackView, convertButton],
        spacing: 20
    )
    private let chartContainerView = UIView().withHeight(500)
    private lazy var contentScrollView = UIScrollView(children: [contentStackView, chartContainerView])

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.viewProtocol = self
        viewModel.getSymbols()
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = menuBarButton
        navigationItem.rightBarButtonItem = signupBarButton
        navigationController?.navigationBar.tintColor = .systemGreen
        
        with(contentScrollView) {
            addSubview($0)
            
            $0.anchor(
                top: safeAreaTopAnchor,
                leading: safeAreaLeadingAnchor,
                bottom: view.bottomAnchor,
                trailing: safeAreaTrailingAnchor
            )
            
            contentStackView.anchor(
                top: $0._topAnchor,
                leading: $0._leadingAnchor,
                trailing: $0._trailingAnchor,
                padding: ._init(top: 30, left: 20, right: 20)
            )
            
            chartContainerView.anchor(
                top: contentStackView.bottomAnchor,
                leading: $0._leadingAnchor,
                bottom: $0.contentLayoutGuide.bottomAnchor,
                trailing: $0._trailingAnchor,
                padding: ._init(top: 50)
            )
            
            $0.offsetContent(bottom: -100)
        }
        
        with(contentStackView) {
            $0.setCustomSpacing(40, after: headerLabel)
            $0.setCustomSpacing(30, after: pickerStackView)
            $0.setCustomSpacing(30, after: newCurrencyInputTextField)
        }
        
        euroPickerView.widthAnchor.constraint(equalTo: newCurrencyPickerView.widthAnchor).isActive = true
        euroPickerView.flag = .euro
        newCurrencyInputTextField.enableUserInteraction(false)
        newCurrencyInputTextField.rightText = "XXX"
        
        newCurrencyPickerView.animateOnTap { [weak self] in
            self?.didTapNewCurrency()
        }
        
        configureChartContainerView()
    }
    
    private func configureChartContainerView() {
        with(chartContainerView) {
            $0.backgroundColor = .systemBlue
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        chartContainerView.addRoundCorners([.topLeft, .topRight], radius: 30)
    }
    
    @objc private func didTapMenuButton() {
        //TODO: Implement menu tap action
    }
    
    @objc private func didTapSignupButton() {
        //TODO: Implement signup tap action
    }
    
    private func didTapNewCurrency() {
        let viewController = CurrenciesViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

}

extension CalculatorViewController: CalculatorViewProtocol {
    func showLoadingAnimation(_ show: Bool) {
        
    }
    
    func showError(_ message: String, type: ToastType) {
        showMessage(message, type: type)
    }
    
    func showConversionResult(_ value: String) {
        
    }
}
