//
//  CitiesViewController.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 2.10.2022.
//

import UIKit

class CitiesViewController: UIViewController {
    
    let tableView = UITableView()
    
    private let citiesViewModel: CitiesViewModel
    
    var constraints: [NSLayoutConstraint] = []
    
    init() {
        self.citiesViewModel = CitiesViewModel()
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
        setNavigationBarItems()
        delegation()
    }
    override func viewDidLayoutSubviews() {
        setGradientBackground()
    }
    /// Adds subviews to the CitiesViewController view
    private func setup() {
        view.addSubview(tableView)
        
       tableView.register(CityCell.self, forCellReuseIdentifier: "cityCell")
    }
    /// Setups view components constraints
    private func setupConstraints() {
        [
            tableView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        constraints.append(contentsOf: [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15)
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

    }
}
extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return citiesViewModel.cities.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return citiesViewModel.cities[section].city
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesViewModel.cities[section].districts?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityCell
        cell.districtLabel.text = citiesViewModel.cities[indexPath.section].districts?[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pricesVC = PricesViewController(city: citiesViewModel.cities[indexPath.section].city ?? "",
                                            district: citiesViewModel.cities[indexPath.section].districts?[indexPath.row].name ?? "")
        navigationController?.pushViewController(pricesVC, animated: true)
    }
}
extension CitiesViewController {
    /// Table View Delegation
    private func delegation() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}
extension CitiesViewController {
    private func setNavigationBarItems() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.gray
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white,.font: UIFont.boldSystemFont(ofSize: 20)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationItem.title = "Select District"
        navigationItem.titleView?.tintColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.white
    }
}
