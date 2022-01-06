//
//  BJCollectionViewCell.swift
//  BJCollection
//
//  Created by Sovannra on 13/12/21.
//

import UIKit

class BJCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponent()
        setupConstraint()
    }
    
    func setupComponent() {}
    func setupConstraint() {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
