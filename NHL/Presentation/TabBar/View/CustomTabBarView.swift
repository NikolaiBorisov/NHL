//
//  CustomTabBarView.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 03.01.2022.
//

import UIKit

final class CustomTabBarView: UITabBar {
    
    // MARK: - Private Properties
    
    private var shapeLayer: CALayer?
    
    // MARK: - Life Cycle
    
    override func draw(_ rect: CGRect) {
        
        addShape()
        setupView()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        unselectedItemTintColor = .white
        tintColor = .white
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = UIColor.white.cgColor
        shapeLayer.shadowOpacity = 0.9
        
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    func createPath() -> CGPath {
        let height: CGFloat = 20
        let path = UIBezierPath()
        let centerWidth = frame.width / 2
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addQuadCurve(
            to: CGPoint(x: frame.width, y: 0),
            controlPoint: CGPoint(x: centerWidth, y: height)
        )
        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        path.close()
        return path.cgPath
    }
    
}
