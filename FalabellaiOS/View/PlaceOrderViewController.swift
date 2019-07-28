//
//  PlaceOrderViewController.swift
//  FalabellaiOS
//
//  Created by Rajagopal Ganesan on 27/07/19.
//  Copyright © 2019 Rajagopal Ganesan. All rights reserved.
//

import UIKit

class PlaceOrderViewController: UIViewController {
    
    @IBOutlet weak var orderCollectionView: UICollectionView!
    @IBOutlet weak var orderButton: UIButton!
    
    var cartModel: [BeerModel] = [BeerModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCollectionViewDataSource()
        // Do any additional setup after loading the view.
    }
    
    private func setCollectionViewDataSource() {
        self.orderCollectionView.dataSource = self
        self.orderCollectionView.delegate = self
    }
    
    
    @IBAction func orderButtonAction(_ sender: UIButton) {
        
        DisplayActivitySpinner.shared.showActivityIndicatory(uiView: self.view)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            DisplayActivitySpinner.shared.hideActivityIndicator()
            let alertController = UIAlertController(title: OrderPlacedTitle, message: OrderPlaced, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                self.dismiss(animated: true, completion: nil)
            }
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        })
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension PlaceOrderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height / 4)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cartModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: UICollectionViewCell!
        if let cell_ = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCellIdentifier, for: indexPath) as? HomeCollectionViewCell {
            
            let currentModel = self.cartModel[indexPath.row]
            cell_.selectedButton.isHidden = true
            cell_.populateValues(model: currentModel, indexPath: indexPath, selectedModel: nil)
            cell = cell_
        }
        
        return cell
        
    }
    
}
