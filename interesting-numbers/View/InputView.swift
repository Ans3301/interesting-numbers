//
//  InputView.swift
//  interesting-numbers
//
//  Created by Мария Анисович on 09.01.2025.
//

import SwifterSwift
import UIKit

final class InputView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Enter here"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var textField: CustomTextPaddingTextField = {
        let textField = CustomTextPaddingTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.layer.cornerRadius = 6
        textField.backgroundColor = UIColor(hexString: "#FAF7FD")
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(hexString: "#F5EFFB")?.cgColor
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupCustomView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCustomView() {
        setupTitleLabel()
        setupTextField()
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 79),
            titleLabel.heightAnchor.constraint(equalToConstant: 21),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
    
    private func setupTextField() {
        textField.delegate = self
        
        addSubview(textField)

        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            textField.widthAnchor.constraint(equalToConstant: 343),
            textField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func clearTextField() {
        textField.clear()
    }
    
    func getText() -> String? {
        return textField.text
    }
}

extension InputView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let characterSet = CharacterSet(charactersIn: "0123456789" + " ")

        if string.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        
        return true
    }
}
