//
//  Extensions.swift
//  NetflixApplication
//
//  Created by pritam on 2024-01-12.
//

import Foundation



// Allows the first letter of the section titles to be capitalized, leaving the rest of letter to be lowercased
extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
