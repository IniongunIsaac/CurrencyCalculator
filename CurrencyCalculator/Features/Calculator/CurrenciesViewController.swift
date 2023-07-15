//
//  CurrenciesViewController.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 15/07/2023.
//

import UIKit

final class CurrenciesViewController: UIViewController {
    
    private let CELL_ID = "CurrencyTableViewCell"
    private var viewModel: CalculatorViewModelProtocol
    
    init(viewModel: CalculatorViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let xmarkImageView = UIImageView(
        image: .xmark,
        tintColor: .appBlue,
        size: 25
    )
    let headerLabel = UILabel(
        text: "Choose Currency.",
        font: .systemFont(ofSize: 20, weight: .black),
        color: .appBlue,
        alignment: .left
    )
    let searchBar = UISearchBar()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundColor = .systemBackground
        setupView()
    }
    
    private func setupView() {
        addSubviews(xmarkImageView, headerLabel, searchBar, tableView)
        
        xmarkImageView.anchor(
            top: safeAreaTopAnchor,
            leading: safeAreaLeadingAnchor,
            padding: ._init(top: 10, left: 16)
        )
        
        headerLabel.anchor(
            top: xmarkImageView.bottomAnchor,
            leading: safeAreaLeadingAnchor,
            trailing: safeAreaTrailingAnchor,
            padding: ._init(allEdges: 20)
        )
        
        with(searchBar) {
            $0.anchor(
                top: headerLabel.bottomAnchor,
                leading: safeAreaLeadingAnchor,
                trailing: safeAreaTrailingAnchor,
                padding: ._init(allEdges: 10)
            )
            $0.placeholder = "Search"
            $0.searchBarStyle = .minimal
        }
        
        with(tableView) {
            $0.anchor(
                top: searchBar.bottomAnchor,
                leading: safeAreaLeadingAnchor,
                bottom: safeAreaBottomAnchor,
                trailing: safeAreaTrailingAnchor
            )
            $0.delegate = self
            $0.dataSource = self
            $0.showIndicators(false)
            $0.register(UITableViewCell.self, forCellReuseIdentifier: CELL_ID)
        }
        
        xmarkImageView.animateOnTap { [weak self] in
            self?.dismiss(animated: true)
        }
        
    }

}

extension CurrenciesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.symbols.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath)
        let symbol = viewModel.symbols[indexPath.row]
        
        cell.imageView?.image = .flag
        cell.textLabel?.text = symbol.name
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let symbol = viewModel.symbols[indexPath.row]
        viewModel.updateSelectedSymbol(symbol)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
}
