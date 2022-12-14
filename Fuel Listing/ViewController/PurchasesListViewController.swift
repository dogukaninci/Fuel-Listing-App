//
//  PurchasesListViewController.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 2.10.2022.
//

import UIKit

class PurchasesListViewController: UIViewController {

    private let tableView = UITableView()
    private let createButton = UIButton()
    
    private let purchasesListViewModel: PurchasesListViewModel
    
    var constraints: [NSLayoutConstraint] = []
    
    init() {
        self.purchasesListViewModel = PurchasesListViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
        style()
        delegation()
        databaseOperation()
        setNavigationBarItems()
    }
    override func viewDidLayoutSubviews() {
        setGradientBackground()
    }
    /// Adds subviews to the PurchasesListViewController view
    private func setup() {
        view.addSubview(tableView)
        view.addSubview(createButton)
        
        tableView.register(FuelCell.self, forCellReuseIdentifier: "fuelCell")
        createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
    }
    /// Setups view components constraints
    private func setupConstraints() {
        [
            tableView,
            createButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        constraints.append(contentsOf: [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: createButton.topAnchor, constant: -20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            createButton.heightAnchor.constraint(equalToConstant: 44),
            createButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            createButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            createButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
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
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.gray
        // clear head inset
        tableView.separatorInset = .zero
        tableView.rowHeight = 44
        tableView.layer.cornerRadius = 7
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        createButton.setTitle("YENİ OLUŞTUR", for: .normal)
        createButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        createButton.setTitleColor(UIColor.darkGray, for: .normal)
        createButton.backgroundColor = UIColor.white
        createButton.layer.cornerRadius = 20
    }
}
extension PurchasesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchasesListViewModel.savedDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fuelCell", for: indexPath) as! FuelCell
        cell.dateLabel.text = purchasesListViewModel.savedDataArray[indexPath.row].date
        cell.fuelTypeLabel.text = purchasesListViewModel.savedDataArray[indexPath.row].fuelType
        cell.literLabel.text = "liter: " + purchasesListViewModel.savedDataArray[indexPath.row].liter + "L"
        cell.buyingPriceLabel.text = purchasesListViewModel.savedDataArray[indexPath.row].price + " TL/L"
        cell.totalPriceLabel.text = "total: " + purchasesListViewModel.savedDataArray[indexPath.row].totalPrice + " TL"
        cell.brandLabel.text = purchasesListViewModel.savedDataArray[indexPath.row].brand
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let purchasesAddEditVC = PurchasesAddEditViewController(object: purchasesListViewModel.savedDataArray[indexPath.row])
        navigationController?.pushViewController(purchasesAddEditVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
extension PurchasesListViewController {
    /// Table View Delegation
    private func delegation() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}
extension PurchasesListViewController {
    @objc func createButtonTapped() {
        let citiesVC = CitiesViewController()
        navigationController?.pushViewController(citiesVC, animated: true)
    }
}
extension PurchasesListViewController {
    func databaseOperation() {
        purchasesListViewModel.readData()
    }
}
extension PurchasesListViewController {
    private func setNavigationBarItems() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.gray
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white,.font: UIFont.boldSystemFont(ofSize: 20)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationItem.title = "Purchases List"
        navigationItem.titleView?.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = .none
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.tintColor = UIColor.white
    }
}
