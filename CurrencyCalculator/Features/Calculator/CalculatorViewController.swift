//
//  CalculatorViewController.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import UIKit

final class CalculatorViewController: UIViewController {
    
    @Provided var viewModel: CalculatorViewModelProtocol

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewProtocol = self
        viewModel.getSymbols()
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
