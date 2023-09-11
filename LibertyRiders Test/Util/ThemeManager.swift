//
//  ThemeManager.swift
//  LibertyRiders Test
//
//  Created by Perso on 9/7/23.
//

import UIKit

final class ThemeManager {
    static let shared = ThemeManager()

    let primary: UIColor = .init(red: 25/255, green: 42/255, blue: 86/255, alpha: 1)
    let secondary: UIColor = .init(red: 1, green: 168/255, blue: 1/255, alpha: 1)
    let backgroundColor: UIColor = .white
    let cardBackground: UIColor = .init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    let photoCardBackground:UIColor = .black
    let blackColor: UIColor = .black
    let loadingBackground: UIColor = UIColor(white: 0, alpha: 0.4)
}
