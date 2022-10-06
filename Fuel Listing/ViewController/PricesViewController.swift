//
//  PricesViewController.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 2.10.2022.
//

import UIKit
import Foundation

class PricesViewController: UIViewController {
    
    let dieselButton = UIButton()
    let gasolineButton = UIButton()
    let stackView = UIStackView()
    
    let tableView = UITableView()
    
    var constraints: [NSLayoutConstraint] = []
    
    private let pricesViewModel: PricesViewModel
    
    init(city: String, district: String) {
        // Create PricesViewModel with city, district info coming from
        //CitiesViewController to PricesViewController seque
        self.pricesViewModel = PricesViewModel(city: city, district: district)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        delegation()
        setupConstraints()
        style()
        initViewModel()
    }
    override func viewDidLayoutSubviews() {
        setGradientBackground()
    }
    /// Adds subviews to the PricesViewController view
    private func setup() {
        stackView.addArrangedSubview(dieselButton)
        stackView.addArrangedSubview(gasolineButton)
        view.addSubview(stackView)
        view.addSubview(tableView)
        
        tableView.register(PriceCell.self, forCellReuseIdentifier: "priceCell")
        dieselButton.addTarget(self, action: #selector(dieselButtonTapped), for: .touchUpInside)
        gasolineButton.addTarget(self, action: #selector(gasolineButtonTapped), for: .touchUpInside)
    }
    /// Setups view components constraints
    private func setupConstraints() {
        [
            dieselButton,
            gasolineButton,
            stackView,
            tableView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        constraints.append(contentsOf: [
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 120),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
        ])
        
        NSLayoutConstraint.activate(constraints) // activates constraints array
    }
    /// add gradient background layer to view
    private func setGradientBackground() {
        let gl = CAGradientLayer()
        gl.colors = [ UIColor.lightGray.cgColor, UIColor.darkGray.cgColor]
        gl.locations = [ 0.0, 1.0]
        gl.frame = self.view.bounds
        self.view.layer.insertSublayer(gl, at:0)
    }
    private func style(){
        dieselButton.setTitle("DIESEL", for: .normal)
        dieselButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        dieselButton.setTitleColor(UIColor.darkGray, for: .normal)
        dieselButton.backgroundColor = UIColor.green
        dieselButton.layer.cornerRadius = 10
        
        gasolineButton.setTitle("GASOLINE", for: .normal)
        gasolineButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        gasolineButton.setTitleColor(UIColor.darkGray, for: .normal)
        gasolineButton.backgroundColor = UIColor.white
        gasolineButton.layer.cornerRadius = 10
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.gray
        // clear head inset
        tableView.separatorInset = .zero
        tableView.rowHeight = 44
        tableView.layer.cornerRadius = 7
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    func initViewModel() {
        // Get prices data
        pricesViewModel.fetchPrices(fuelType: "diesel")
        
        // Reload TableView closure
        DispatchQueue.main.async {
            self.pricesViewModel.reloadTableView = { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}
extension PricesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pricesViewModel.fuelType == "diesel" {
            return pricesViewModel.diesel.count
        } else {
            return pricesViewModel.gasoline.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "priceCell", for: indexPath) as! PriceCell
        if pricesViewModel.fuelType == "diesel" {
            cell.brandLabel.text = pricesViewModel.diesel[indexPath.row].marka!
            cell.firstLabel.text = "DIESEL"
            cell.firstPriceLabel.text = String(format: "%.2f",pricesViewModel.diesel[indexPath.row].dizel ?? 0)
            cell.secondLabel.text = "DOPED"
            cell.secondPriceLabel.text = pricesViewModel.parseJson(value: pricesViewModel.diesel[indexPath.row].katkili!)
        } else {
            cell.brandLabel.text = pricesViewModel.gasoline[indexPath.row].marka!
            cell.firstLabel.text = "GASOLINE"
            cell.firstPriceLabel.text = String(format: "%.2f",pricesViewModel.gasoline[indexPath.row].benzin ?? 0)
            cell.secondLabel.text = "DOPED"
            cell.secondPriceLabel.text = pricesViewModel.parseJson(value: pricesViewModel.gasoline[indexPath.row].katkili!)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if pricesViewModel.fuelType == "diesel" {
            let purchasesAddEditVC = PurchasesAddEditViewController(normalPrice: String(format: "%2.2f",pricesViewModel.diesel[indexPath.row].dizel ?? 0),
                                                                    dopedPrice: pricesViewModel.parseJson(value: pricesViewModel.diesel[indexPath.row].katkili!),
                                                                    brand: pricesViewModel.diesel[indexPath.row].marka!,
                                                                    fuelType: pricesViewModel.fuelType)
            navigationController?.pushViewController(purchasesAddEditVC, animated: true)
        } else {
            let purchasesAddEditVC = PurchasesAddEditViewController(normalPrice: String(format: "%2.2f",pricesViewModel.gasoline[indexPath.row].benzin ?? 0),
                                                                    dopedPrice: pricesViewModel.parseJson(value: pricesViewModel.gasoline[indexPath.row].katkili!),
                                                                    brand: pricesViewModel.gasoline[indexPath.row].marka!,
                                                                    fuelType: pricesViewModel.fuelType)
            navigationController?.pushViewController(purchasesAddEditVC, animated: true)

        }
    }
}
extension PricesViewController {
    /// Table View Delegation
    private func delegation() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}
extension PricesViewController {
    @objc func dieselButtonTapped() {
        dieselButton.backgroundColor = UIColor.green
        gasolineButton.backgroundColor = UIColor.white
        pricesViewModel.changeFuelType(fuelType: "diesel")
        pricesViewModel.fetchPrices(fuelType: "diesel")
    }
    @objc func gasolineButtonTapped() {
        gasolineButton.backgroundColor = UIColor.green
        dieselButton.backgroundColor = UIColor.white
        pricesViewModel.changeFuelType(fuelType: "gasoline")
        pricesViewModel.fetchPrices(fuelType: "gasoline")
    }
}
