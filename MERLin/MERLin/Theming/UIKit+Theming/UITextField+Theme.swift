//
//  UITextField+Theme.swift
//  Module
//
//  Created by Giuseppe Lanza on 30/04/18.
//  Copyright © 2018 Gilt. All rights reserved.
//

import UIKit

public extension UITextField {
    public func applyBoxedStyle(usingTheme theme: ThemeProtocol = ThemeManager.defaultTheme, withTextStyle style: ThemeFontStyle, customizing: ((UITextField, ThemeProtocol)-> Void)? = nil) {
        theme.configureBoxedTextField(textfield: self, withTextStyle: style, customizing: customizing)
    }
}
