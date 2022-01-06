//
//  TopViewMask.swift
//  BJImagePreview
//
//  Created by Sovannra on 6/1/22.
//

import UIKit

class TopViewMask: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .init(white: 0.5, alpha: 0.2)
        setupComponent()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupComponent() {
        addSubview(vtopView)
        vtopView.addSubview(vPotoCount)
    }
    
    private func setupConstraint() {
        //vTopView
        vtopView.topAnchor.constraint(equalTo: self.topAnchor, constant: ImageAppConstant.statusBarHeight).isActive = true
        vtopView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        vtopView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        vtopView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        vtopView.heightAnchor.constraint(equalToConstant: UINavigationController.navBarHeight()).isActive = true
        
        //vPhotoCount
        vPotoCount.centerXAnchor.constraint(equalTo: vtopView.centerXAnchor).isActive = true
        vPotoCount.centerYAnchor.constraint(equalTo: vtopView.centerYAnchor).isActive = true
    }
    
    func setupPhotoCount(count: Int, total: Int) {
        vPotoCount.text = "\(count + 1)/\(total)"
    }
    
    let vtopView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let vPotoCount: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = .systemFont(ofSize: 18, weight: .semibold)
        return view
    }()
}
