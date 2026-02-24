//
//  RoundIconButton.swift
//  Bike App
//
//  Created by Denis on 24.02.2026.
//

import UIKit

final class RoundIconButton: UIButton {

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
        backgroundColor = AppTheme.Color.background.withAlphaComponent(0.85)
        tintColor = AppTheme.Color.accent
        layer.cornerRadius = 14
        layer.borderWidth = 1
        layer.borderColor = AppTheme.Color.accent.withAlphaComponent(0.6).cgColor
        layer.masksToBounds = true

        let symbol = UIImage(systemName: "chevron.right")
        setImage(symbol, for: .normal)
        setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .semibold), forImageIn: .normal)
    }
}
