//
//  Models.swift
//  CryptoHelper
//
//  Created by Max Pavlov on 29.01.22.
//

import Foundation

struct Crypto: Codable {
    let id: String?
    let currency: String?
    let symbol: String?
    let name: String?
    let price: String?
    let logo_url: String?
}
