//
//  CustomSpinnerRefreshControl.swift
//  refresher
//
//  Created by Lorin on 25/11/19.
//  Copyright © 2019 Lorin. All rights reserved.
//

import UIKit

class CustomSpinnerRefreshControl: UIRefreshControl {
    
    private var isAnimating = false
    
    private lazy var spinnerView: UIImageView = {
        let bundle = Bundle(for: type(of: self))
        let imageView = UIImageView(image: UIImage(named: "donut", in: bundle, compatibleWith: nil))
        return imageView
    }()
    
    private let contentView = UIView()
    private let animationSegmentTime = 1.0
    
    override public init() {
        super.init()
        buildView()
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func animate() {
        isAnimating = true
        
        UIView.animate(withDuration: animationSegmentTime, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: { () -> Void in
            self.spinnerView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }, completion: { (finished) -> Void in
            UIView.animate(withDuration: self.animationSegmentTime, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: { () -> Void in
                self.spinnerView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
            }, completion: { (finished) -> Void in
                if self.isRefreshing {
                    self.animate()
                } else {
                    self.isAnimating = false
                }
            })
        })
    }
    
    private func buildView() {
        backgroundColor = .clear
        tintColor = .clear
        
        contentView.addSubview(spinnerView)
        addSubview(contentView)
    }
    
    private func buildLayout() {
        contentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(600)
            make.height.equalTo(50)
        }
        spinnerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(50)
        }
    }
}
