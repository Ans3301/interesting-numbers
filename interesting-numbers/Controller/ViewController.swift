//
//  ViewController.swift
//  interesting-numbers
//
//  Created by Мария Анисович on 08.01.2025.
//

import NumFacts
import SwifterSwift
import UIKit

enum UserValidationError: Error {
    case unsuccessfulValidation(ValidationError)
    case emptyOneNumberInput
    case emptySeveralNumberInput
    case redundantInput

    var errorMessage: String {
        switch self {
        case .emptyOneNumberInput:
            return "Please enter number."
        case .emptySeveralNumberInput:
            return "Please enter numbers."
        case .redundantInput:
            return "Please enter only one number."
        case .unsuccessfulValidation(let validationError):
            return validationError.errorMessage
        }
    }
}

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
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 9
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
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
    
    private let numFacts = NumFacts()

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
        
        titleLabel.accessibilityIdentifier = "titleLabel"

        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.78),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 88),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupSubtitleLabel() {
        view.addSubview(subtitleLabel)
        
        subtitleLabel.accessibilityIdentifier = "subtitleLabel"

        NSLayoutConstraint.activate([
            subtitleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            subtitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupDiceView() {
        view.addSubview(diceView)
        
        diceView.accessibilityIdentifier = "diceView"

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
        
        userNumberButton.accessibilityIdentifier = "userNumberButton"
        randomNumberButton.accessibilityIdentifier = "randomNumberButton"
        numberInRangeButton.accessibilityIdentifier = "numberInRangeButton"
        multipleNumbersButton.accessibilityIdentifier = "multipleNumbersButton"
        
        userNumberButton.isSelected = true
        
        for button in buttons {
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 75)
            ])
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
        
        view.addSubview(buttonsStackView)
        
        buttonsStackView.accessibilityIdentifier = "buttonsStackView"

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
        
        enterView.accessibilityIdentifier = "enterView"
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        NSLayoutConstraint.activate([
            enterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterView.topAnchor.constraint(equalTo: view.topAnchor, constant: 580),
            enterView.heightAnchor.constraint(equalToConstant: 70),
            enterView.widthAnchor.constraint(equalToConstant: 343)
        ])
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if enterView.textFieldIsEditing() {
                if view.frame.origin.y == 0 {
                    view.frame.origin.y -= keyboardSize.height / 3 * 2
                }
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }

    private func setupDisplayButton() {
        view.addSubview(displayButton)
        
        displayButton.accessibilityIdentifier = "displayButton"
        
        NSLayoutConstraint.activate([
            displayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            displayButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 670),
            displayButton.heightAnchor.constraint(equalToConstant: 52),
            displayButton.widthAnchor.constraint(equalToConstant: 343)
        ])
        
        displayButton.addTarget(self, action: #selector(displayButtonTapped), for: .touchUpInside)
    }
    
    @objc private func displayButtonTapped(_ button: UIButton) {
        Task {
            do {
                let facts = try await getFacts()
                self.present(facts: facts)
            } catch let error as UserValidationError {
                self.presentAlert(text: error.errorMessage)
            } catch let error as ValidationError {
                self.presentAlert(text: error.errorMessage)
            } catch {
                self.presentAlert(text: error.localizedDescription)
            }
        }
    }
    
    private func getFacts() async throws -> [Fact] {
        var facts: [Fact] = []
        
        if userNumberButton.isSelected {
            let fact = try await getFactAboutNumber()
            facts.append(fact)
        } else if randomNumberButton.isSelected {
            let fact = try await getFactAboutRandomNumber()
            facts.append(fact)
        } else if numberInRangeButton.isSelected {
            let fact = try await getFactAboutRandomNumberInRange()
            facts.append(fact)
        } else {
            facts = try await getFactsAboutMultipleNumbers()
        }
        
        return facts
    }
    
    private func getFactAboutNumber() async throws -> Fact {
        let text = enterView.getText()
        
        guard let string = text?.trimmingCharacters(in: .whitespaces),
              !string.isEmpty
        else {
            throw UserValidationError.emptyOneNumberInput
        }

        guard string.components(separatedBy: " ").count == 1 else {
            throw UserValidationError.redundantInput
        }
        
        guard let number = Int64(string) else {
            throw UserValidationError.emptyOneNumberInput
        }
        
        return try await numFacts.factAboutNumber(number: number)
    }
    
    private func getFactAboutRandomNumber() async throws -> Fact {
        return try await numFacts.factAboutRandomNumber()
    }
    
    private func getFactAboutRandomNumberInRange() async throws -> Fact {
        let text = enterView.getText()
        
        guard let numbers = text?.trimmingCharacters(in: .whitespaces).components(separatedBy: " "),
              !numbers.isEmpty
        else {
            throw UserValidationError.emptySeveralNumberInput
        }

        guard numbers.count == 2,
              let min = Int64(numbers[0]),
              let max = Int64(numbers[1])
        else {
            throw UserValidationError.unsuccessfulValidation(.incorrectRangeInput)
        }

        return try await numFacts.factAboutRandomNumberInRange(min: min, max: max)
    }
    
    private func getFactsAboutMultipleNumbers() async throws -> [Fact] {
        let text = enterView.getText()
        
        guard let numbers = text?.trimmingCharacters(in: .whitespaces).components(separatedBy: " "),
              !numbers.isEmpty
        else {
            throw UserValidationError.emptySeveralNumberInput
        }

        guard numbers.count > 1 else {
            throw UserValidationError.unsuccessfulValidation(.insufficientInput)
        }
        
        let array = numbers.map { Int64($0) }
        if array.contains(nil) {
            throw UserValidationError.emptySeveralNumberInput
        }
        
        return try await numFacts.factsAboutMultipleNumbers(numbers: array.compactMap { $0 })
    }

    private func present(facts: [Fact]) {
        let factViewController = FactViewController()
        factViewController.facts = facts
        factViewController.modalPresentationStyle = .overFullScreen
        factViewController.modalTransitionStyle = .crossDissolve
        present(factViewController, animated: true)
    }
    
    private func presentAlert(text: String) {
        let alert = UIAlertController(title: "Failed", message: text, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
