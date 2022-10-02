//
//  CityCell.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 2.10.2022.
//

import UIKit

class CityCell: UITableViewCell {
    
    let districtLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupConstraints()
        configureStyle()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Adds subviews to the CityCell
    private func setup() {
        contentView.addSubview(districtLabel)
    }
    /// Setups view components constraints
    private func setupConstraints() {
        [
            districtLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            districtLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            districtLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10)
        ])
    }
    private func configureStyle() {
        backgroundColor = .clear
        
        districtLabel.font = UIFont.boldSystemFont(ofSize: 20)
        districtLabel.textColor = UIColor.white
        
    }
    
}

