//
//  PriceCell.swift
//  Fuel Listing
//
//  Created by Doğukan Inci on 3.10.2022.
//

import UIKit

class PriceCell: UITableViewCell {
    
    let firstLabel = UILabel()
    let firstPriceLabel = UILabel()
    let secondLabel = UILabel()
    let secondPriceLabel = UILabel()
    let brandLabel = UILabel()
    let firstStackView = UIStackView()
    let secondStackView = UIStackView()
    let stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupConstraints()
        configureStyle()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// Adds subviews to the PriceCell
    private func setup() {
        firstStackView.addArrangedSubview(firstLabel)
        firstStackView.addArrangedSubview(firstPriceLabel)
        secondStackView.addArrangedSubview(secondLabel)
        secondStackView.addArrangedSubview(secondPriceLabel)
        stackView.addArrangedSubview(firstStackView)
        stackView.addArrangedSubview(secondStackView)
        contentView.addSubview(brandLabel)
        contentView.addSubview(stackView)
    }
    /// Setups view components constraints
    private func setupConstraints() {
        [
            firstLabel,
            firstPriceLabel,
            secondLabel,
            secondPriceLabel,
            brandLabel,
            firstStackView,
            secondStackView,
            stackView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            secondStackView.leftAnchor.constraint(equalTo: firstLabel.rightAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
    }
    private func configureStyle() {
        backgroundColor = .clear
        
        firstStackView.axis = .vertical
        firstStackView.distribution = .equalCentering
        firstStackView.alignment = .center
        
        secondStackView.axis = .vertical
        secondStackView.distribution = .equalCentering
        secondStackView.alignment = .center
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        brandLabel.font = UIFont.boldSystemFont(ofSize: 20)
        brandLabel.textColor = UIColor.white
        
        firstLabel.font = UIFont.boldSystemFont(ofSize: 20)
        firstLabel.textColor = UIColor.white
        firstPriceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        firstPriceLabel.textColor = UIColor.white
        
        secondLabel.font = UIFont.boldSystemFont(ofSize: 20)
        secondLabel.textColor = UIColor.white
        secondPriceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        secondPriceLabel.textColor = UIColor.white
        
    }
}
