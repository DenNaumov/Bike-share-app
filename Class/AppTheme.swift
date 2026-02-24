//
//  AppTheme.swift
//  Bike App
//
//  Created by Denis on 24.02.2026.
//

import UIKit

enum AppTheme {
    enum Color {
        static let background = UIColor.black
        static let accent = UIColor(red: 0.3137, green: 0.8902, blue: 0.7608, alpha: 1.0)
        static let textPrimary = UIColor.white
        static let inputBackground = UIColor.systemGray2
        static let inputBorderRegular = UIColor.clear
        static let inputBorderActive = UIColor(red: 0.3137, green: 0.8902, blue: 0.7608, alpha: 1.0)
        static let inputBorderError = UIColor.systemRed
        static let error = UIColor.systemRed
    }

    enum Font {
        static let inputLabel = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let inputText = UIFont.systemFont(ofSize: 14, weight: .regular)
        static let error = UIFont.systemFont(ofSize: 12, weight: .regular)
        static let button = UIFont.systemFont(ofSize: 20, weight: .light)
    }
}
