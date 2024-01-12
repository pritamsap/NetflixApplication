//
//  APICaller.swift
//  NetflixApplication
//
//  Created by pritam on 2024-01-12.
//

import Foundation


struct Constants {
    static let API_KEY = ConfigurationManager.shared.apiKey
}

class APICaller {
    static let share  = APICaller()
}
