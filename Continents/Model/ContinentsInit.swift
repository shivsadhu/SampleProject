//
//  ContinentsInit.swift
//  Continents
//
//  Created by Shivani Ramanathan on 1/5/23.
//

import Foundation

/*struct ContinentInit {
    let continents: String
    let country: [String]
    let descriptions: [String]
    init(continents: String, country: [String], descriptions: [String]) {
        self.continents = continents
        self.country = country
        self.descriptions = descriptions
    }
}
import Foundation */

// MARK: - Result
struct Result: Codable {
    let continents: [Continents]
  
}

// MARK: - Continent
struct Continents: Codable {
    let continentName: String
    let country: [Country]
}

// MARK: - Country
struct Country: Codable {
    let countryName: String
    let details: Details
}

// MARK: - Details
struct Details: Codable {
    let capital, currency: String
}


