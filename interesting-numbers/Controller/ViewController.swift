//
//  ViewController.swift
//  interesting-numbers
//
//  Created by Мария Анисович on 08.01.2025.
//

import SwifterSwift
import UIKit

final class ViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Interesting Numbers"
        label.font = UIFont(name: "OpenSans-Bold", size: 28)
        label.textColor = UIColor(hexString: "#2D2D2D")
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "This App about facts of Numbers and Dates"
        label.font = UIFont(name: "OpenSans-Light", size: 16)
        label.textColor = UIColor(hexString: "#000000")
        label.numberOfLines = 2
        return label
    }()

    private lazy var diceView: DiceView = {
        let view = DiceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupTitleLabel()
        setupSubtitleLabel()
        setupDiceView()
    }

    private func setupTitleLabel() {
        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 320),
            titleLabel.heightAnchor.constraint(equalToConstant: 38),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 88),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupSubtitleLabel() {
        view.addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            subtitleLabel.widthAnchor.constraint(equalToConstant: 242),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 53),
            subtitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupDiceView() {
        view.addSubview(diceView)

        NSLayoutConstraint.activate([
            diceView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            diceView.topAnchor.constraint(equalTo: view.topAnchor, constant: 253),
            diceView.heightAnchor.constraint(equalToConstant: 144),
            diceView.widthAnchor.constraint(equalToConstant: 180)
        ])
    }
}
