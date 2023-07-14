//
//  CalculatorViewController.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import UIKit

final class CalculatorViewController: UIViewController {
    
    @Provided var viewModel: CalculatorViewModelProtocol
    
    lazy var menuBarButton = UIBarButtonItem(image: .menu, style: .plain, target: self, action: #selector(didTapMenu))
    let signupButton = UIButton(title: "Sign up", textColor: .systemGreen)
    lazy var signupBarButton = UIBarButtonItem(title: "Sign up", style: .plain, target: self, action: #selector(didTapSignup))

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
    }
    
    @objc private func didTapMenu() {
        
    }
    
    @objc private func didTapSignup() {
        
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
