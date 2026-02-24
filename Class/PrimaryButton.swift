//
//  PrimaryButton.swift
//  Bike App
//
//  Created by Denis on 24.02.2026.
//

import UIKit

final class PrimaryButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        applyStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyStyle()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyle()
    }

    private func applyStyle() {
        backgroundColor = AppTheme.Color.background.withAlphaComponent(0.75)
        setTitleColor(AppTheme.Color.accent, for: .normal)
        titleLabel?.font = AppTheme.Font.button
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = AppTheme.Color.accent.withAlphaComponent(0.5).cgColor
        layer.masksToBounds = true
    }
}
