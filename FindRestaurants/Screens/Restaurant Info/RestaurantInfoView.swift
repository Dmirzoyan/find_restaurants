//
//  RestaurantInfo.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

final class RestaurantInfoView: UIView {
    
    private var nameLabel: UILabel!
    private var distanceLabel: UILabel!
    private var nameContainer: UIView!
    private var imageView: UIImageView!
    private var streetLabel: UILabel!
    private var cityLabel: UILabel!
    private var countryLabel: UILabel!
    private var addressContainer: UIView!
    private var contactLabel: UILabel!
    private var contactContainer: UIView!
    private var urlLabel: UILabel!
    private var urlContainer: UIView!
    
    private struct Constatns {
        static let topMargin: CGFloat = 30
        static let sideMargin: CGFloat = 20
        static let imageHeight: CGFloat = 150
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.AppTheme.dargGray
        
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        addShadow()
        layoutNameView()
        layoutImageView()
        layoutAddressView()
        layoutContactView()
        layoutUrlView()
    }
    
    func set(viewState: RestaurantInfoViewState) {
        nameLabel.attributedText = NSAttributedString(
            string: viewState.name,
            attributes: TextAttributes.largeHeavy
        )
        distanceLabel.attributedText = NSAttributedString(
            string: viewState.distance,
            attributes: TextAttributes.smallLight
        )
        
        imageView.image = viewState.image
        
        streetLabel.attributedText = NSAttributedString(
            string: viewState.street,
            attributes: TextAttributes.mediumLight
        )
        cityLabel.attributedText = NSAttributedString(
            string: viewState.city,
            attributes: TextAttributes.mediumLight
        )
        countryLabel.attributedText = NSAttributedString(
            string: viewState.country,
            attributes: TextAttributes.mediumLight
        )
        
        contactLabel.attributedText = NSAttributedString(
            string: viewState.phone ?? "",
            attributes: TextAttributes.mediumLight
        )
        
        urlLabel.attributedText = NSAttributedString(
            string: viewState.url ?? "",
            attributes: TextAttributes.mediumBlue
        )
    }
    
    private func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
    }
    
    private func layoutNameView() {
        nameContainer = UIView()
        nameContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameContainer)
        
        addNameContent()
        
        NSLayoutConstraint.activate([
            nameContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constatns.sideMargin),
            nameContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constatns.sideMargin),
            nameContainer.topAnchor.constraint(equalTo: topAnchor, constant: Constatns.topMargin)
        ])
    }
    
    private func addNameContent() {
        nameLabel = addLabel(to: nameContainer)
        distanceLabel = addLabel(to: nameContainer)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: nameContainer.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: nameContainer.topAnchor),
            distanceLabel.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: nameContainer.trailingAnchor),
            distanceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            distanceLabel.bottomAnchor.constraint(equalTo: nameContainer.bottomAnchor),
        ])
        
        distanceLabel.textAlignment = .left
        nameLabel.textAlignment = .left
    }
    
    private func layoutImageView() {
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constatns.sideMargin),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constatns.sideMargin),
            imageView.heightAnchor.constraint(equalToConstant: Constatns.imageHeight),
            imageView.topAnchor.constraint(equalTo: nameContainer.bottomAnchor, constant: 20)
        ])
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = UIColor.AppTheme.dargGray
    }
    
    private func layoutAddressView() {
        addressContainer = UIView()
        addressContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addressContainer)
        
        addAddressContent()
        
        NSLayoutConstraint.activate([
            addressContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constatns.sideMargin),
            addressContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constatns.sideMargin),
            addressContainer.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
        ])
    }
    
    private func addAddressContent() {
        let addressLabel = addLabel(to: addressContainer)
        streetLabel = addLabel(to: addressContainer)
        cityLabel = addLabel(to: addressContainer)
        countryLabel = addLabel(to: addressContainer)
        
        NSLayoutConstraint.activate([
            addressLabel.leadingAnchor.constraint(equalTo: addressContainer.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: addressContainer.trailingAnchor),
            addressLabel.topAnchor.constraint(equalTo: addressContainer.topAnchor),
            streetLabel.leadingAnchor.constraint(equalTo: addressContainer.leadingAnchor),
            streetLabel.trailingAnchor.constraint(equalTo: addressContainer.trailingAnchor),
            streetLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 3),
            cityLabel.leadingAnchor.constraint(equalTo: addressContainer.leadingAnchor),
            cityLabel.trailingAnchor.constraint(equalTo: addressContainer.trailingAnchor),
            cityLabel.topAnchor.constraint(equalTo: streetLabel.bottomAnchor, constant: 4),
            countryLabel.leadingAnchor.constraint(equalTo: addressContainer.leadingAnchor),
            countryLabel.trailingAnchor.constraint(equalTo: addressContainer.trailingAnchor),
            countryLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 4),
            countryLabel.bottomAnchor.constraint(equalTo: addressContainer.bottomAnchor),
        ])
        
        addressLabel.textAlignment = .left
        streetLabel.textAlignment = .left
        cityLabel.textAlignment = .left
        countryLabel.textAlignment = .left
        
        addressLabel.attributedText = NSAttributedString(
            string: "Address",
            attributes: TextAttributes.smallGray
        )
    }
    
    private func layoutContactView() {
        contactContainer = UIView()
        contactContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contactContainer)
        
        addContactContent()
        
        NSLayoutConstraint.activate([
            contactContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constatns.sideMargin),
            contactContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constatns.sideMargin),
            contactContainer.topAnchor.constraint(equalTo: addressContainer.bottomAnchor, constant: 20)
        ])
    }
    
    private func addContactContent() {
        let phoneLabel = addLabel(to: contactContainer)
        contactLabel = addLabel(to: contactContainer)
        
        NSLayoutConstraint.activate([
            phoneLabel.leadingAnchor.constraint(equalTo: contactContainer.leadingAnchor),
            phoneLabel.trailingAnchor.constraint(equalTo: contactContainer.trailingAnchor),
            phoneLabel.topAnchor.constraint(equalTo: contactContainer.topAnchor),
            contactLabel.leadingAnchor.constraint(equalTo: contactContainer.leadingAnchor),
            contactLabel.trailingAnchor.constraint(equalTo: contactContainer.trailingAnchor),
            contactLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 4),
            contactLabel.bottomAnchor.constraint(equalTo: contactContainer.bottomAnchor),
        ])
        
        phoneLabel.textAlignment = .left
        contactLabel.textAlignment = .left
        
        phoneLabel.attributedText = NSAttributedString(
            string: "Phone",
            attributes: TextAttributes.smallGray
        )
    }
    
    private func layoutUrlView() {
        urlContainer = UIView()
        urlContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(urlContainer)
        
        addUrlContent()
        
        NSLayoutConstraint.activate([
            urlContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constatns.sideMargin),
            urlContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constatns.sideMargin),
            urlContainer.topAnchor.constraint(equalTo: contactContainer.bottomAnchor, constant: 20)
        ])
    }
    
    private func addUrlContent() {
        let websiteLabel = addLabel(to: urlContainer)
        urlLabel = addLabel(to: urlContainer)
        
        NSLayoutConstraint.activate([
            websiteLabel.leadingAnchor.constraint(equalTo: urlContainer.leadingAnchor),
            websiteLabel.trailingAnchor.constraint(equalTo: urlContainer.trailingAnchor),
            websiteLabel.topAnchor.constraint(equalTo: urlContainer.topAnchor),
            urlLabel.leadingAnchor.constraint(equalTo: urlContainer.leadingAnchor),
            urlLabel.trailingAnchor.constraint(equalTo: urlContainer.trailingAnchor),
            urlLabel.topAnchor.constraint(equalTo: websiteLabel.bottomAnchor, constant: 4),
            urlLabel.bottomAnchor.constraint(equalTo: urlContainer.bottomAnchor),
        ])
        
        websiteLabel.textAlignment = .left
        urlLabel.textAlignment = .left
        
        websiteLabel.attributedText = NSAttributedString(
            string: "Website",
            attributes: TextAttributes.smallGray
        )
    }
    
    private func addLabel(to view: UIView) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        view.addSubview(label)
        
        return label
    }
}
