//
//  MyTableViewCell.swift
//  CryptoHelper
//
//  Created by Max Pavlov on 29.01.22.
//

import UIKit

struct CryptoTableViewCellViewModel {
    let name:       String
    let symbol:     String
    let price:      String
    let logo_url:   String
}

class CryptoTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImage:   UIImageView!
    @IBOutlet weak var nameLabel:   UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var priceLabel:  UILabel!
    
    static let identifier = "CryptoTableViewCell"
    
    func configure(with viewModel: CryptoTableViewCellViewModel) {
        nameLabel.text = viewModel.name
        symbolLabel.text = viewModel.symbol
        priceLabel.text = viewModel.price
        let url = URL(string: "https://cryptoicon-api.vercel.app/api/icon/\(viewModel.symbol.lowercased())")
        DispatchQueue.main.async {
            if let data = try? Data(contentsOf: url!) {
                self.logoImage.image = UIImage(data: data)
            }
        }
    }
}
