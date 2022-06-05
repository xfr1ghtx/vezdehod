//
//  Pin.swift
//  passwordCodeScreen
//
//  Created by Developer on 04.06.2022.
//

import UIKit

class Pin: UIView {
    
    let viewModel = PinViewModel()
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 12, height: 12))
        setup()
        bindToViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 6, y: 6), radius: CGFloat(6), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
            
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 2.0
            
        layer.addSublayer(shapeLayer)
        layer.cornerRadius = 6
        layer.backgroundColor = UIColor.clear.cgColor
    }
    
    private func bindToViewModel(){
        viewModel.didDeleteCode = {[weak self] in
            self?.layer.backgroundColor = UIColor.clear.cgColor
        }
        
        viewModel.didEnterCode = {[weak self] in
            self?.layer.backgroundColor = UIColor.white.cgColor
        }
    }
    
    
}
