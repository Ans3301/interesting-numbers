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
    
    private var userNumberButton = NumberTypeButton()
    private var randomNumberButton = NumberTypeButton()
    private var numberInRangeButton = NumberTypeButton()
    private var multipleNumbersButton = NumberTypeButton()
    
    private lazy var buttons = [userNumberButton, randomNumberButton, numberInRangeButton, multipleNumbersButton]
    private lazy var buttonsStackView = UIStackView(arrangedSubviews: buttons)
    
    private lazy var enterView: InputView = {
        let view = InputView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var displayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(hexString: "#8033CC")
        button.setTitle("Display Fact", for: .normal)
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "OpenSans-SemiBold", size: 18)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupTitleLabel()
        setupSubtitleLabel()
        setupDiceView()
        setupButtonsStackView()
        setupEnterView()
        setupDisplayButton()
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
    
    private func setupButtonsStackView() {
        userNumberButton.setTitle("User number", for: .normal)
        randomNumberButton.setTitle("Random number", for: .normal)
        numberInRangeButton.setTitle("Number in a range", for: .normal)
        multipleNumbersButton.setTitle("Multiple numbers", for: .normal)
        
        userNumberButton.isSelected = true
        
        for button in buttons {
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 75)
            ])
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 9
        buttonsStackView.distribution = .equalSpacing
        
        view.addSubview(buttonsStackView)

        NSLayoutConstraint.activate([
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 486),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 74)
        ])
    }
    
    @objc private func buttonTapped(_ button: UIButton) {
        if button === randomNumberButton {
            enterView.isHidden = true
        } else {
            enterView.clearTextField()
            enterView.isHidden = false
        }
        
        for b in buttons {
            if b !== button {
                b.isSelected = false
            }
        }
    }
    
    private func setupEnterView() {
        view.addSubview(enterView)

        NSLayoutConstraint.activate([
            enterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterView.topAnchor.constraint(equalTo: view.topAnchor, constant: 580),
            enterView.heightAnchor.constraint(equalToConstant: 70),
            enterView.widthAnchor.constraint(equalToConstant: 343)
        ])
    }
    
    private func setupDisplayButton() {
        view.addSubview(displayButton)
        
        NSLayoutConstraint.activate([
            displayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            displayButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 670),
            displayButton.heightAnchor.constraint(equalToConstant: 52),
            displayButton.widthAnchor.constraint(equalToConstant: 343)
        ])
        
        displayButton.addTarget(self, action: #selector(displayButtonTapped), for: .touchUpInside)
    }
    
    @objc private func displayButtonTapped(_ button: UIButton) {
        Task.detached {
            do {
                let facts = try await fetchFactFromAPI(numberType: await self.getNumberType(), string: await self.enterView.getText())
                await self.present(facts: facts)
            } catch ValidationError.emptyOneNumberInput {
                await self.presentAlert(text: "Please enter number.")
            } catch ValidationError.emptySeveralNumberInput {
                await self.presentAlert(text: "Please enter numbers.")
            } catch ValidationError.redundantInput {
                await self.presentAlert(text: "Please enter only one number.")
            } catch ValidationError.insufficientInput {
                await self.presentAlert(text: "Please enter more than one number.")
            } catch ValidationError.incorrectRangeInput {
                await self.presentAlert(text: "Please enter two numbers, the first of which is less than the second.")
            } catch {
                await self.presentAlert(text: error.localizedDescription)
            }
        }
    }

    @MainActor
    private func getNumberType() -> NumberType {
        if userNumberButton.isSelected {
            return .userNumber
        } else if randomNumberButton.isSelected {
            return .randomNumber
        } else if numberInRangeButton.isSelected {
            return .numberInRange
        } else {
            return .multipleNumbers
        }
    }
    
    @MainActor
    private func present(facts: [Fact]) {
        let factViewController = FactViewController()
        factViewController.facts = facts
        factViewController.modalPresentationStyle = .overFullScreen
        factViewController.modalTransitionStyle = .crossDissolve
        present(factViewController, animated: true)
    }
    
    @MainActor
    private func presentAlert(text: String) {
        let alert = UIAlertController(title: "Failed", message: text, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { _ in
        })
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}
