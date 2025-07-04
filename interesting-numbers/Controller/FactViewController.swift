//
//  FactViewController.swift
//  interesting-numbers
//
//  Created by Мария Анисович on 09.01.2025.
//

import NumFacts
import SwifterSwift
import UIKit

final class FactViewController: UIViewController {
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "OpenSans-Bold", size: 28)
        label.textColor = .white
        return label
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "OpenSans-SemiBold", size: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "icon_close"), for: .normal)
        return button
    }()
    
    var facts: [Fact]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hexString: "#8033CC")
        
        if facts.count == 1 {
            setupNumberLabel()
        }
        setupLabel()
        setupBackButton()
    }
    
    private func setupNumberLabel() {
        numberLabel.text = String(Int64(facts[0].number))
        
        view.addSubview(numberLabel)
        
        numberLabel.accessibilityIdentifier = "numberLabel"

        NSLayoutConstraint.activate([
            numberLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            numberLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 88),
            numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupLabel() {
        label.text = facts.map { $0.text }.joined(separator: "\n")
        
        view.addSubview(label)
        
        label.accessibilityIdentifier = "label"

        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.87),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupBackButton() {
        view.addSubview(backButton)
        
        backButton.accessibilityIdentifier = "backButton"

        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 22),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            backButton.rightAnchor.constraint(equalTo: label.rightAnchor)
        ])
        
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped(_ button: UIButton) {
        dismiss(animated: true)
    }
}
