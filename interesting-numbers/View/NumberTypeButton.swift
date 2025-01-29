//
//  NumberTypeButton.swift
//  interesting-numbers
//
//  Created by Мария Анисович on 08.01.2025.
//

import SwifterSwift
import UIKit

final class NumberTypeButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.numberOfLines = 2
        self.titleLabel?.font = UIFont(name: "OpenSans-SemiBold", size: 13)

        self.setStandardAppearance()

        self.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
    }

    private func setStandardAppearance() {
        self.backgroundColor = UIColor(hexString: "#FAF7FD")
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(hexString: "#F5EFFB")?.cgColor
        self.setTitleColor(UIColor(hexString: "#2D2D2D"), for: .normal)
    }

    private func setSelectedAppearance() {
        self.backgroundColor = UIColor(hexString: "#8033CC")
        self.layer.borderWidth = 0
        self.setTitleColor(.white, for: .normal)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.addShadow()
    }

    private func addShadow() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 6
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 6).cgPath
        self.layer.shadowColor = UIColor(hexString: "#000000")?.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.15
        self.layer.shadowRadius = 2
    }

    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.setSelectedAppearance()
                self.layer.shadowOpacity = 0
            } else {
                self.setStandardAppearance()
                self.layer.shadowOpacity = 0.15
            }
        }
    }

    @objc func buttonTapped(_ button: UIButton) {
        button.isSelected = true
    }
}
