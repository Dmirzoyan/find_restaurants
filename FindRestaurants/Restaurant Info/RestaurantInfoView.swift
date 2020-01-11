//
//  RestaurantInfo.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

final class RestaurantInfoView: UIView {
    
    static let borderMargin: CGFloat = 5
    
    private var nameLabel: UILabel!
    private var distanceLabel: UILabel!
    private var nameContainer: UIView!
    
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
        layoutTitle()
    }
    
    func set(viewState: RestaurantInfoViewState) {
        nameLabel.attributedText = NSAttributedString(
            string: viewState.name,
            attributes: TextAttributes.largeHeavy
        )
        distanceLabel.attributedText = NSAttributedString(
            string: viewState.distance,
            attributes: TextAttributes.mediumLight
        )
    }
    
    private func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
    }
    
    private func layoutTitle() {
        nameContainer = UIView()
        nameContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameContainer)
        
        addTitleContent()
        
        NSLayoutConstraint.activate([
            nameContainer.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            nameContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameContainer.topAnchor.constraint(equalTo: topAnchor, constant: 25)
        ])
    }
    
    private func addTitleContent() {
        nameLabel = addLabel(to: nameContainer)
        distanceLabel = addLabel(to: nameContainer)
        
        NSLayoutConstraint.activate([
            nameLabel.widthAnchor.constraint(equalToConstant: 300),
            nameLabel.topAnchor.constraint(equalTo: nameContainer.topAnchor),
            distanceLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            distanceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            distanceLabel.bottomAnchor.constraint(equalTo: nameContainer.bottomAnchor),
        ])
        
        distanceLabel.textAlignment = .left
        nameLabel.textAlignment = .left
    }
    
    private func addLabel(to view: UIView) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        view.addSubview(label)
        
        return label
    }
}
