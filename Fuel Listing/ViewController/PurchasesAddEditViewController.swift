//
//  PurchasesAddEditViewController.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 4.10.2022.
//

import UIKit

class PurchasesAddEditViewController: UIViewController {
    
    let normalButton = UIButton()
    let dopedButton = UIButton()
    let stackView = UIStackView()
    
    let buyingPriceLabel = UILabel()
    let buyingPriceText = UITextField()
    let literLabel = UILabel()
    let literText = UITextField()
    let totalPriceLabel = UILabel()
    let totalPriceText = UITextField()
    
    let containerView = UIView()
    let receiptImage = UIImageView()
    
    private let saveButton = UIButton()
    
    var constraints: [NSLayoutConstraint] = []
    
    private let purchasesAddEditViewModel: PurchasesAddEditViewModel
    
    init(normalPrice: String, dopedPrice: String, brand: String, fuelType: String) {
        // Create PricesViewModel with city, district info coming from
        //CitiesViewController to PricesViewController seque
        self.purchasesAddEditViewModel = PurchasesAddEditViewModel(normalPrice: normalPrice, dopedPrice: dopedPrice, brand: brand, fuelType: fuelType)
        super.init(nibName: nil, bundle: nil)
    }
    init(object: DbModel) {
        self.purchasesAddEditViewModel = PurchasesAddEditViewModel(object: object)
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
        placeholderChanger()
    }
    override func viewDidLayoutSubviews() {
        setGradientBackground()
    }
    /// Adds subviews to the PurchasesAddEditViewController view
    private func setup() {
        stackView.addArrangedSubview(normalButton)
        stackView.addArrangedSubview(dopedButton)
        containerView.addSubview(buyingPriceLabel)
        containerView.addSubview(buyingPriceText)
        containerView.addSubview(literLabel)
        containerView.addSubview(literText)
        containerView.addSubview(totalPriceLabel)
        containerView.addSubview(totalPriceText)
        view.addSubview(stackView)
        view.addSubview(saveButton)
        view.addSubview(containerView)
        view.addSubview(receiptImage)
        
        normalButton.addTarget(self, action: #selector(normalButtonTapped), for: .touchUpInside)
        dopedButton.addTarget(self, action: #selector(dopedButtonTapped), for: .touchUpInside)
        
        buyingPriceText.addTarget(self, action: #selector(buyingTextChange(_:)), for: .editingChanged)
        buyingPriceText.addTarget(self, action: #selector(buyingTextBeginEditing(_:)), for: .editingDidBegin)
        literText.addTarget(self, action: #selector(literTextChange(_:)), for: .editingChanged)
        literText.addTarget(self, action: #selector(literTextBeginEditing(_:)), for: .editingDidBegin)
        totalPriceText.addTarget(self, action: #selector(totalPriceTextChange(_:)), for: .editingChanged)
        totalPriceText.addTarget(self, action: #selector(totalPriceTextBeginEditing(_:)), for: .editingDidBegin)
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
    }
    /// Setups view components constraints
    private func setupConstraints() {
        [
            normalButton,
            dopedButton,
            stackView,
            buyingPriceLabel,
            buyingPriceText,
            literLabel,
            literText,
            totalPriceLabel,
            totalPriceText,
            containerView,
            saveButton,
            receiptImage
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        constraints.append(contentsOf: [
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 120),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            containerView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            containerView.heightAnchor.constraint(equalToConstant: 200),
            
            buyingPriceLabel.bottomAnchor.constraint(equalTo: literLabel.topAnchor, constant: -15),
            buyingPriceLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 25),
            
            buyingPriceText.centerYAnchor.constraint(equalTo: buyingPriceLabel.centerYAnchor),
            buyingPriceText.leftAnchor.constraint(equalTo: buyingPriceLabel.rightAnchor, constant: 25),
            buyingPriceText.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -25),
            
            literLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            literLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 25),
            
            literText.centerYAnchor.constraint(equalTo: literLabel.centerYAnchor),
            literText.centerXAnchor.constraint(equalTo: buyingPriceText.centerXAnchor),
            literText.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -25),
            
            totalPriceLabel.topAnchor.constraint(equalTo: literLabel.bottomAnchor, constant: 15),
            totalPriceLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 25),
            
            totalPriceText.centerYAnchor.constraint(equalTo: totalPriceLabel.centerYAnchor),
            totalPriceText.centerXAnchor.constraint(equalTo: literText.centerXAnchor),
            totalPriceText.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -25),
            
            receiptImage.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
            receiptImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            receiptImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            receiptImage.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: 10),
            
            saveButton.heightAnchor.constraint(equalToConstant: 44),
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            saveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
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
        normalButton.setTitle("NORMAL", for: .normal)
        normalButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        normalButton.setTitleColor(UIColor.darkGray, for: .normal)
        normalButton.backgroundColor = UIColor.green
        normalButton.layer.cornerRadius = 10
        
        dopedButton.setTitle("DOPED", for: .normal)
        dopedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        dopedButton.setTitleColor(UIColor.darkGray, for: .normal)
        dopedButton.backgroundColor = UIColor.white
        dopedButton.layer.cornerRadius = 10
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        buyingPriceLabel.font = UIFont.systemFont(ofSize: 25)
        buyingPriceLabel.textColor = UIColor.white
        buyingPriceLabel.text = "Price:"
        buyingPriceText.font = UIFont.systemFont(ofSize: 25)
        buyingPriceText.textColor = UIColor.white
        buyingPriceText.text = purchasesAddEditViewModel.price
        
        literLabel.font = UIFont.systemFont(ofSize: 25)
        literLabel.textColor = UIColor.white
        literLabel.text = "Liter:"
        literText.font = UIFont.systemFont(ofSize: 25)
        literText.textColor = UIColor.white
        
        totalPriceLabel.font = UIFont.systemFont(ofSize: 25)
        totalPriceLabel.textColor = UIColor.white
        totalPriceLabel.text = "Total:"
        totalPriceText.font = UIFont.systemFont(ofSize: 25)
        totalPriceText.textColor = UIColor.white
        
        saveButton.setTitle("KAYDET", for: .normal)
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        saveButton.setTitleColor(UIColor.darkGray, for: .normal)
        saveButton.backgroundColor = UIColor.white
        saveButton.layer.cornerRadius = 20
        
    }
    @objc private func buyingTextChange(_ textField: UITextField) {
        purchasesAddEditViewModel.price = textField.text!
        placeholderChanger()
    }
    @objc private func buyingTextBeginEditing(_ textField: UITextField) {
        purchasesAddEditViewModel.priceTrigger = true
        purchasesAddEditViewModel.literTrigger = false
        purchasesAddEditViewModel.totalPriceTrigger = false
    }
    
    @objc private func literTextChange(_ textField: UITextField) {
        purchasesAddEditViewModel.liter = textField.text!
        placeholderChanger()
    }
    @objc private func literTextBeginEditing(_ textField: UITextField) {
        purchasesAddEditViewModel.literTrigger = true
        purchasesAddEditViewModel.priceTrigger = false
        purchasesAddEditViewModel.totalPriceTrigger = false
    }
    
    @objc private func totalPriceTextChange(_ textField: UITextField) {
        purchasesAddEditViewModel.totalPrice = textField.text!
        placeholderChanger()
    }
    @objc private func totalPriceTextBeginEditing(_ textField: UITextField) {
        purchasesAddEditViewModel.totalPriceTrigger = true
        purchasesAddEditViewModel.priceTrigger = false
        purchasesAddEditViewModel.literTrigger = false
    }
    private func placeholderChanger() {
        buyingPriceText.text = purchasesAddEditViewModel.price
        literText.text = purchasesAddEditViewModel.liter
        totalPriceText.text = purchasesAddEditViewModel.totalPrice
    }
    @objc func saveButtonTapped() {
        purchasesAddEditViewModel.saveData()
        
        let purchasesListVC = PurchasesListViewController()
        navigationController?.pushViewController(purchasesListVC, animated: true)
    }
}
extension PurchasesAddEditViewController {
    @objc func normalButtonTapped() {
        normalButton.backgroundColor = UIColor.green
        dopedButton.backgroundColor = UIColor.white
        purchasesAddEditViewModel.changePriceToNormal()
        placeholderChanger()
    }
    @objc func dopedButtonTapped() {
        dopedButton.backgroundColor = UIColor.green
        normalButton.backgroundColor = UIColor.white
        purchasesAddEditViewModel.changePriceToDoped()
        placeholderChanger()
    }
}
