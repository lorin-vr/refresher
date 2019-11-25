//
//  CustomSpinnerRefreshControl.swift
//  refresher
//
//  Created by Lorin on 25/11/19.
//  Copyright © 2019 Lorin. All rights reserved.
//

import UIKit

class CustomSpinnerRefreshControl: UIRefreshControl {
    
    private lazy var spinner: UIImage? = {
        let bundle = Bundle(for: type(of: self))
        return UIImage(named: "donut", in: bundle, compatibleWith: nil)
    }()
    
    private let contentView = UIView()
    
    // Needs to be lazy because we don't have contentView.bounds yet
    private lazy var spinnerLayer: CALayer = {
        let layer = CALayer()
        layer.contents = spinner?.cgImage
        layer.frame = contentView.bounds
        layer.contentsScale = 3.0
        layer.contentsGravity = CALayerContentsGravity.center
        return layer
    }()
    
    private let rotation: CAKeyframeAnimation = {
       let rotation = CAKeyframeAnimation(keyPath: "transform.rotation")
        rotation.keyTimes = [0, 0.5, 1.0]
        rotation.values = [0, CGFloat(Double.pi), CGFloat(Double.pi * 2)]
        rotation.duration = 1.6
        rotation.repeatCount = Float.infinity
        rotation.isRemovedOnCompletion = false
        return rotation
    }()
    
    override public init() {
        super.init()
        buildView()
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func beginRefreshing() {
        super.beginRefreshing()
        animate()
    }
    
    override public func endRefreshing() {
        super.endRefreshing()
        
        // It would be nice to remove the animation here, but endRefreshing() is called too early.
        // If we remove it here, the spinner will disappear before it slides up off screen
//        spinnerLayer.removeAllAnimations()
//        spinnerLayer.removeFromSuperlayer()
    }
    
    private var setUpComplete: Bool = false
    
    private func setUpAnimation() {
        contentView.layer.addSublayer(spinnerLayer)
        spinnerLayer.add(rotation, forKey: "transform.rotation")
        setUpComplete = true
    }
    
    // MARK:- Private helpers
    private func animate() {
        if !setUpComplete {     // Add the layer with animation only once so we don't end up with a leak
            setUpAnimation()
        }
    }
    
    private func buildView() {
        backgroundColor = .clear
        tintColor = .clear
        
        addSubview(contentView)
    }
    
    private func buildLayout() {
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(600)
            make.height.equalTo(50)
        }
    }
}
