//
//  HomePageViewModel.swift
//  FalabellaiOS
//
//  Created by Rajagopal Ganesan on 27/07/19.
//  Copyright © 2019 Rajagopal Ganesan. All rights reserved.
//

import UIKit

protocol ViewModelProtocol {
    func isModelAssociatedWithValues(status: Bool)
}

class HomePageViewModel: NSObject {
    
    var model: [BeerModel] = [BeerModel]()
    var delegate: ViewModelProtocol!
    
    func getBeersList(viewController: UIViewController) {
        
        ApiController.shared.performRestAPI(url: ApiUrlToGetBeers, viewController: viewController, restType: .get, inputParams: nil) { (error, jsonResp) in
            DispatchQueue.main.async { [weak self] in
                if let strongSelf = self {
                    guard let jsonResp_ = jsonResp else {
                        strongSelf.delegate.isModelAssociatedWithValues(status: false)
                        return
                    }
                    for value in jsonResp_ {
                        strongSelf.model.append(BeerModel(dictionary: value as NSDictionary)!)
                    }
                    strongSelf.delegate.isModelAssociatedWithValues(status: true)
                    print("Processeing data done..!!")
                }
            }
        }
    }
}
