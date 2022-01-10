//
//  TopViewMask.swift
//  BJImagePreview
//
//  Created by Sovannra on 6/1/22.
//

import UIKit

class TopViewMask: UIView {
    
    fileprivate var vtopViewConstraint: NSLayoutConstraint?
    weak var delegate: ImageViewerPagerVCDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .init(white: 0.5, alpha: 0.2)
        setupComponent()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        vtopViewConstraint?.constant = ImageAppConstant.statusBarHeight
    }
    
    private func setupComponent() {
        addSubview(vtopView)
        vtopView.addSubview(vClose)
        vtopView.addSubview(vPotoCount)
    }
    
    private func setupConstraint() {
        //vTopView
        vtopViewConstraint = vtopView.topAnchor.constraint(equalTo: self.topAnchor, constant: ImageAppConstant.statusBarHeight)
        vtopViewConstraint?.isActive = true
        vtopView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        vtopView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        vtopView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        vtopView.heightAnchor.constraint(equalToConstant: UINavigationController.navBarHeight()).isActive = true
        
        //vClose
        if #available(iOS 11.0, *) {
            vClose.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 14).isActive = true
        } else {
            vClose.leftAnchor.constraint(equalTo: vtopView.leftAnchor, constant: 14).isActive = true
        }
        vClose.centerYAnchor.constraint(equalTo: vtopView.centerYAnchor).isActive = true
        vClose.widthAnchor.constraint(equalToConstant: 25).isActive = true
        vClose.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
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
    
    lazy var vClose: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .white
        view.setImage(UIImage(named: "icon-back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        view.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        return view
    }()
    
    @objc func handleClose() {
        delegate?.handleClose()
    }
}
