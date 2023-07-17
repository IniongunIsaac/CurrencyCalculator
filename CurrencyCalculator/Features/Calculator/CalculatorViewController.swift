//
//  CalculatorViewController.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import UIKit
import DGCharts

final class CalculatorViewController: UIViewController {
    
    @Provided var viewModel: CalculatorViewModelProtocol
    
    lazy var menuBarButton = UIBarButtonItem(
        image: .menu,
        style: .plain,
        target: self,
        action: #selector(didTapMenuButton)
    )
    let signupButton = UIButton(
        title: "Sign up",
        textColor: .systemGreen
    )
    lazy var signupBarButton = UIBarButtonItem(
        title: "Sign up",
        style: .plain,
        target: self,
        action: #selector(didTapSignupButton)
    )
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
    let chartView = LineChartView().withHeight(400)
    private let chartContainerView = UIView()
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
                padding: ._init(top: 20, left: 20, right: 20)
            )
            
            chartContainerView.anchor(
                top: contentStackView.bottomAnchor,
                leading: $0._leadingAnchor,
                bottom: $0.contentLayoutGuide.bottomAnchor,
                trailing: $0._trailingAnchor,
                padding: ._init(top: 50)
            )
            
            $0.offsetContent(bottom: -50)
        }
        
        with(contentStackView) {
            $0.setCustomSpacing(40, after: headerLabel)
            $0.setCustomSpacing(30, after: pickerStackView)
            $0.setCustomSpacing(30, after: newCurrencyInputTextField)
        }
        
        with(euroPickerView) {
            $0.widthAnchor.constraint(equalTo: newCurrencyPickerView.widthAnchor).isActive = true
            $0.flag = .euro
            $0.enableUserInteraction(false, alpha: 0.7)
        }
        
        newCurrencyInputTextField.enableUserInteraction(false, alpha: 0.7)
        newCurrencyInputTextField.rightText = "XXX"
        
        newCurrencyPickerView.animateOnTap { [weak self] in
            self?.didTapNewCurrency()
        }
        
        newCurrencyPickerView.text = "XXX"
        
        convertButton.addTarget(self, action: #selector(didTapConvertButton), for: .touchUpInside)
        
        configureChartContainerView()
    }
    
    private func configureChartContainerView() {
        let past30DaysButton = UIButton(
            title: "Past 30 days",
            font: .systemFont(ofSize: 16, weight: .semibold),
            textColor: .white
        )
        
        let past90DaysButton = UIButton(
            title: "Past 90 days",
            font: .systemFont(ofSize: 16, weight: .semibold),
            textColor: .white.withAlphaComponent(0.5)
        )
        
        let buttonsStackView = UIHStack(
            subviews: [past30DaysButton, past90DaysButton],
            spacing: 30
        )
        
        let getRatesLabel = UILabel(
            text: "Get rate alerts straight to your inbox",
            font: .systemFont(ofSize: 15),
            color: .white,
            alignment: .center,
            underlined: true
        )
        
        with(chartContainerView) {
            $0.backgroundColor = .systemBlue
            $0.addSubviews(chartView, buttonsStackView, getRatesLabel)
            
            buttonsStackView.centerXInSuperview()
            buttonsStackView.anchor(
                top: $0.topAnchor,
                padding: ._init(top: 30)
            )
            
            chartView.anchor(
                top: buttonsStackView.bottomAnchor,
                leading: $0.leadingAnchor,
                bottom: getRatesLabel.topAnchor,
                trailing: $0.trailingAnchor,
                padding: ._init(allEdges: 20)
            )
            
            getRatesLabel.anchor(
                leading: $0.leadingAnchor,
                bottom: $0.bottomAnchor,
                trailing: $0.trailingAnchor,
                padding: ._init(topBottom: 80, leftRight: 20)
            )
        }
        
        configureChartView()
        
        getRatesLabel.animateOnTap { [weak self] in
            self?.showMessage("Get rates in inbox.")
        }
    }
    
    private func configureChartView() {
        let numberOfDays = 15
        
        var dates = [String]()
        let chartDataEntries = (1...numberOfDays).map { (dateValue) -> ChartDataEntry in
            dates.append("\(dateValue) Jun.")
            let amountValue = Double(arc4random_uniform(70))
            return ChartDataEntry(x: Double(dateValue), y: amountValue, icon: nil)
        }
        
        let gradientColors = [UIColor.white.withAlphaComponent(0.3).cgColor, UIColor.white.withAlphaComponent(0.8).cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        let chartDataSet = LineChartDataSet(entries: chartDataEntries, label: "")
        
        with(chartDataSet) {
            $0.lineDashLengths = nil
            $0.highlightLineDashLengths = nil
            $0.setColors(.clear)
            $0.gradientPositions = [0, 40, 100]
            $0.drawCircleHoleEnabled = false
            $0.drawValuesEnabled = false
            $0.drawCirclesEnabled = false
            
            $0.fillAlpha = 1
            $0.fill = LinearGradientFill(gradient: gradient, angle: 90)
            $0.drawFilledEnabled = true
        }
        
        chartView.rightAxis.enabled = false
        
        with(chartView.leftAxis) {
            $0.labelTextColor = .white
            $0.drawGridLinesEnabled = false
        }
        
        with(chartView.xAxis) {
            $0.labelTextColor = .white
            $0.labelPosition = .bottom
            $0.drawGridLinesEnabled = false
            $0.valueFormatter = IndexAxisValueFormatter(values: dates)
            $0.granularity = 1
        }
        
        let marker = BalloonMarker(
            color: .appGreen,
            font: .systemFont(ofSize: 12),
            textColor: .white,
            insets: .init(top: 8, left: 8, bottom: 20, right: 8)
        )
        let chartData = LineChartData(dataSet: chartDataSet)
        with(chartView) {
            $0.data = chartData
            $0.animate(xAxisDuration: 1.5, yAxisDuration: 1.5)
            marker.chartView = $0
            marker.minimumSize = CGSize(width: 80, height: 40)
            $0.marker = marker
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        chartContainerView.addRoundCorners([.topLeft, .topRight], radius: 30)
    }
    
    @objc private func didTapMenuButton() {
        showMessage("Menu tapped")
    }
    
    @objc private func didTapSignupButton() {
        showMessage("Signup tapped")
    }
    
    private func didTapNewCurrency() {
        let viewController = CurrenciesViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
    @objc private func didTapConvertButton() {
        viewModel.convert(amount: euroInputTextField.text)
    }

}

extension CalculatorViewController: CalculatorViewProtocol {
    
    /// Displays or hides loading animation on the UI
    /// - Parameter show: A boolean value that indicates whether or not the loading animation should be displayed
    func showLoadingAnimation(_ show: Bool) {
        showLoader(show, interactionEnabled: !show)
    }
    
    func showError(_ message: String, type: ToastType) {
        showMessage(message, type: type)
    }
    
    /// Shows the result of conversion on the UI
    /// - Parameter value: amount to be displayed on the UI
    func showConversionResult(_ value: String) {
        newCurrencyInputTextField.text = value
    }
    
    /// Updates the picker view and the currency input with the symbol selected
    /// - Parameter symbol: `DBSymbol` to be used for the UI update
    func didChooseSymbol(_ symbol: DBSymbol) {
        newCurrencyPickerView.text = symbol.code
        newCurrencyInputTextField.rightText = symbol.code
        newCurrencyInputTextField.text = ""
    }
}
