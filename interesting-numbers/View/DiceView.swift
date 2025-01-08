//
//  DiceView.swift
//  interesting-numbers
//
//  Created by Мария Анисович on 08.01.2025.
//

import SwifterSwift
import UIKit

final class DiceView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let firstDice = getFirstDice()
        let secondDice = getSecondDice()
        layer.addSublayer(firstDice)
        layer.addSublayer(secondDice)
    }

    private func getFirstDice() -> CAShapeLayer {
        let roundedRect = UIBezierPath(roundedRect: CGRect(x: 90, y: 54, width: 90, height: 90),
                                       cornerRadius: 16)
        let roundedRectShape = CAShapeLayer()
        roundedRectShape.path = roundedRect.cgPath
        roundedRectShape.lineWidth = 9.0
        roundedRectShape.fillColor = UIColor.clear.cgColor
        roundedRectShape.strokeColor = UIColor(hexString: "#FAF7FD")?.cgColor
        
        let circle = UIBezierPath(ovalIn: CGRect(x: 128, y: 92, width: 14, height: 14))
        
        let circleShape = CAShapeLayer()
        circleShape.path = circle.cgPath
        circleShape.fillColor = UIColor(hexString: "#FAF7FD")?.cgColor
        
        roundedRectShape.addSublayer(circleShape)
        
        return roundedRectShape
    }
    
    private func getSecondDice() -> CAShapeLayer {
        let roundedRect = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 90, height: 90),
                                       cornerRadius: 16)
        let roundedRectShape = CAShapeLayer()
        roundedRectShape.path = roundedRect.cgPath
        roundedRectShape.lineWidth = 9.0
        roundedRectShape.fillColor = UIColor.white.cgColor
        roundedRectShape.strokeColor = UIColor(hexString: "#FAF7FD")?.cgColor
        
        let firstCircle = UIBezierPath(ovalIn: CGRect(x: 38, y: 38, width: 14, height: 14))
        let secondCircle = UIBezierPath(ovalIn: CGRect(x: 21, y: 21, width: 14, height: 14))
        let thirdCircle = UIBezierPath(ovalIn: CGRect(x: 55, y: 21, width: 14, height: 14))
        let fourthCircle = UIBezierPath(ovalIn: CGRect(x: 21, y: 55, width: 14, height: 14))
        let fifthCircle = UIBezierPath(ovalIn: CGRect(x: 55, y: 55, width: 14, height: 14))
        
        let circles = [firstCircle, secondCircle, thirdCircle, fourthCircle, fifthCircle]
        
        for circle in circles {
            let circleShape = CAShapeLayer()
            circleShape.path = circle.cgPath
            circleShape.fillColor = UIColor(hexString: "#FAF7FD")?.cgColor
            roundedRectShape.addSublayer(circleShape)
        }
        
        roundedRectShape.transform = CATransform3DMakeRotation(CGFloat.pi / 4, 0, 0, 1)
        roundedRectShape.position = CGPoint(x: 63, y: 0)
        
        return roundedRectShape
    }
}
