//
//  CustomTextPaddingTextField.swift
//  interesting-numbers
//
//  Created by Мария Анисович on 09.01.2025.
//

import UIKit

final class CustomTextPaddingTextField: UITextField {
    private let textPadding = UIEdgeInsets(
        top: 0,
        left: 16,
        bottom: 0,
        right: 16
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
}
