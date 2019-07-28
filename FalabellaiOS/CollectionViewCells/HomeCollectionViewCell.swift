//
//  HomeCollectionViewCell.swift
//  FalabellaiOS
//
//  Created by Rajagopal Ganesan on 27/07/19.
//  Copyright © 2019 Rajagopal Ganesan. All rights reserved.
//

import UIKit

protocol HomeCellDelegate: NSObjectProtocol {
    func didSelectItemButton(indexPathRow: Int, isSelected: Bool, beerId: Int)
}

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var contentLevel: UILabel!
    @IBOutlet weak var selectedButton: BeerSelectButton!
    @IBOutlet weak var style: UITextView!
    var beerId_: Int = 0
    var delegate: HomeCellDelegate!
    
    override func prepareForReuse() {
        self.selectedButton.deselect()
    }
    
    @IBAction func selectButtonAction(_ sender: BeerSelectButton) {
        var isSelected_ = false
        
        if sender.isSelected {
            // deselect
            sender.deselect()
            
        } else {
            // select with animation
            sender.select()
            isSelected_ = true
        }
        print(beerId_)
        self.delegate.didSelectItemButton(indexPathRow: sender.tag, isSelected: isSelected_, beerId: beerId_)
    }
    
    func populateValues(model: BeerModel, indexPath: IndexPath, selectedModel: [BeerModel]?) {
        
        if let selectedModel_ = selectedModel {
            if(self.performSelectOperation(currentModel: model, selectedModel: selectedModel_)) {
                self.selectedButton.select()
            }
        }
        self.title.text = model.name!
        self.style.text = model.style!
        self.contentLevel.text = ContentLevel + model.abv!
        self.selectedButton.tag = indexPath.row
        self.beerId_ = model.id!
    }
    
    func performSelectOperation(currentModel: BeerModel, selectedModel: [BeerModel]) -> Bool{
        
        let filteredIndices = selectedModel.indices.filter {selectedModel[$0].id == currentModel.id}
        if (filteredIndices.count > 0) {
            return true
        } else {
            return false
        }
        
    }
}
