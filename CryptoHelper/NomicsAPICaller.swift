//
//  APICaller.swift
//  CryptoHelper
//
//  Created by Max Pavlov on 29.01.22.
//

import Foundation

final class NomicsAPICaller {
    static let shared = NomicsAPICaller()

    private struct Constans {
        static let apiKey = "65d826b99ad9177574292332ff03b21ca80d24b6"
        static let assetsEndpoint = "https://api.nomics.com/v1/currencies/"
    }
    
    private init() { }
    
    public func getAllCryptoData( completion: @escaping (Result<[Crypto], Error>) -> Void) {
        guard let url = URL(string: Constans.assetsEndpoint + "ticker?key=" + Constans.apiKey + "&ranks=1&interval=1d,30d&convert=USD&per-page=10&page=1") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let jsonResult = try JSONDecoder().decode([Crypto].self, from: data)
                completion(.success(jsonResult))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
