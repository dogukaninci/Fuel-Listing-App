//
//  FuelCell.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 2.10.2022.
//

import UIKit

class FuelCell: UITableViewCell {
    
    let dateLabel = UILabel()
    let buyingPriceLabel = UILabel()
    let totalPriceLabel = UILabel()
    let literLabel = UILabel()
    let fuelTypeLabel = UILabel()
    let brandLabel = UILabel()
    let upperInfoContainerView = UIView()
    let lowerInfoContainerView = UIView()
    let allContainerView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupConstraints()
        configureStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Adds subviews to the FuelCell
    private func setup() {
        allContainerView.addSubview(brandLabel)
        upperInfoContainerView.addSubview(dateLabel)
        upperInfoContainerView.addSubview(totalPriceLabel)
        lowerInfoContainerView.addSubview(fuelTypeLabel)
        lowerInfoContainerView.addSubview(buyingPriceLabel)
        lowerInfoContainerView.addSubview(literLabel)
        allContainerView.addSubview(upperInfoContainerView)
        allContainerView.addSubview(lowerInfoContainerView)
        contentView.addSubview(allContainerView)
    }
    /// Setups view components constraints
    private func setupConstraints() {
        [
            dateLabel,
            buyingPriceLabel,
            totalPriceLabel,
            literLabel,
            fuelTypeLabel,
            brandLabel,
            upperInfoContainerView,
            lowerInfoContainerView,
            allContainerView
        ].forEach {
          $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            brandLabel.topAnchor.constraint(equalTo: allContainerView.topAnchor, constant: 5),
            brandLabel.centerXAnchor.constraint(equalTo: allContainerView.centerXAnchor),
            
            upperInfoContainerView.leftAnchor.constraint(equalTo: allContainerView.leftAnchor, constant: 15),
            upperInfoContainerView.rightAnchor.constraint(equalTo: allContainerView.rightAnchor, constant: -15),
            upperInfoContainerView.heightAnchor.constraint(equalToConstant: 44),
            upperInfoContainerView.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 5),
            
            lowerInfoContainerView.leftAnchor.constraint(equalTo: allContainerView.leftAnchor, constant: 15),
            lowerInfoContainerView.rightAnchor.constraint(equalTo: allContainerView.rightAnchor, constant: -15),
            lowerInfoContainerView.heightAnchor.constraint(equalToConstant: 44),
            lowerInfoContainerView.topAnchor.constraint(equalTo: upperInfoContainerView.bottomAnchor, constant: 10),
            
            dateLabel.leftAnchor.constraint(equalTo: upperInfoContainerView.leftAnchor, constant: 15),
            dateLabel.centerYAnchor.constraint(equalTo: upperInfoContainerView.centerYAnchor),
            
            totalPriceLabel.rightAnchor.constraint(equalTo: upperInfoContainerView.rightAnchor, constant: -15),
            totalPriceLabel.centerYAnchor.constraint(equalTo: upperInfoContainerView.centerYAnchor),
            
            literLabel.centerXAnchor.constraint(equalTo: lowerInfoContainerView.centerXAnchor),
            literLabel.centerYAnchor.constraint(equalTo: lowerInfoContainerView.centerYAnchor),
            
            buyingPriceLabel.rightAnchor.constraint(equalTo: lowerInfoContainerView.rightAnchor, constant: -15),
            buyingPriceLabel.centerYAnchor.constraint(equalTo: lowerInfoContainerView.centerYAnchor),
            
            fuelTypeLabel.leftAnchor.constraint(equalTo: lowerInfoContainerView.leftAnchor, constant:  15),
            fuelTypeLabel.centerYAnchor.constraint(equalTo: literLabel.centerYAnchor),
            
            allContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            allContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            allContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            allContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    private func configureStyle() {
        backgroundColor = .clear
        
        brandLabel.font = UIFont.boldSystemFont(ofSize: 20)
        brandLabel.textColor = UIColor.white
        
        upperInfoContainerView.backgroundColor = UIColor.lightGray
        upperInfoContainerView.layer.shadowColor = UIColor.darkGray.cgColor
        upperInfoContainerView.layer.shadowOpacity = 0.2
        upperInfoContainerView.layer.shadowOffset = .zero
        upperInfoContainerView.layer.shadowRadius = 15
        upperInfoContainerView.layer.cornerRadius = 5
        
        lowerInfoContainerView.backgroundColor = UIColor.lightGray
        lowerInfoContainerView.layer.shadowColor = UIColor.darkGray.cgColor
        lowerInfoContainerView.layer.shadowOpacity = 0.2
        lowerInfoContainerView.layer.shadowOffset = .zero
        lowerInfoContainerView.layer.shadowRadius = 15
        lowerInfoContainerView.layer.cornerRadius = 5
        
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = UIColor.white
        
        totalPriceLabel.font = UIFont.systemFont(ofSize: 14)
        totalPriceLabel.textColor = UIColor.white
        
        fuelTypeLabel.font = UIFont.systemFont(ofSize: 14)
        fuelTypeLabel.textColor = UIColor.white
        
        literLabel.font = UIFont.systemFont(ofSize: 14)
        literLabel.textColor = UIColor.white
        
        buyingPriceLabel.font = UIFont.systemFont(ofSize: 14)
        buyingPriceLabel.textColor = UIColor.white
        
        allContainerView.backgroundColor = UIColor.darkGray
        allContainerView.layer.cornerRadius = 7
        
    }

}
