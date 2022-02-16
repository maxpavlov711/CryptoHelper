//
//  ViewController.swift
//  CryptoHelper
//
//  Created by Max Pavlov on 29.01.22.
//

import UIKit

class CryptoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModels = [CryptoTableViewCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Loader")
        tableView.delegate = self
        tableView.dataSource = self
        
        NomicsAPICaller.shared.getAllCryptoData { [weak self] result in
            switch result {
            case .success(let models):
                print(models.count)
                print(models[0].name! + " - " + models[0].price!)
                self?.viewModels = models.compactMap({
                    CryptoTableViewCellViewModel(name: ($0.name ?? "N/A"),
                                                 symbol: ($0.symbol ?? "N/A"),
                                                 price: ($0.price ?? "N/A"),
                                                 logo_url: ($0.logo_url ?? "")
                    )
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                print("Nooooo good")
            }
        }
    }
}

extension CryptoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier, for: indexPath) as? CryptoTableViewCell else { fatalError() }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
}

