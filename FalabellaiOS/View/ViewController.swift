//
//  ViewController.swift
//  FalabellaiOS
//
//  Created by Rajagopal Ganesan on 21/07/19.
//  Copyright © 2019 Rajagopal Ganesan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var rootCollectionView: UICollectionView!
    private var viewModel: HomePageViewModel = HomePageViewModel()
    private var search: UISearchController!
    private var actualModel: [BeerModel]!
    private var selectedModel: [BeerModel] = [BeerModel]()
    private var searchBarText = ""
    private var cartCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBar()
        self.checkAndUpdateCartBadge()
        self.viewModel.delegate = self
        self.viewModel.getBeersList(viewController: self)
        // Do any additional setup after loading the view.
    }
    
    private func setUpCollectionViewDelegates() {
        self.actualModel = self.viewModel.model
        self.rootCollectionView.dataSource = self
        self.rootCollectionView.delegate = self
    }
    
    private func checkAndUpdateCartBadge() {
        self.addBadge(itemvalue: String(self.cartCount))
    }
    
    private func setUpNavigationBar() {
        self.title = "BeerCraftOnline"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.search = UISearchController(searchResultsController: nil)           // Declare the searchController
        self.navigationItem.searchController = search                           // Write this line in viewDidLoad function
        self.search.searchBar.showsCancelButton = false
        
        self.search.searchBar.delegate = self
    }
    
    private func addBadge(itemvalue: String) {
        
        let bagButton = BadgeButton()
        bagButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        bagButton.tintColor = UIColor.darkGray
        bagButton.setImage(UIImage(named: "Cart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        bagButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 15)
        bagButton.badge = itemvalue
        bagButton.addTarget(self, action: #selector(self.cartButtonTapped), for: UIControl.Event.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bagButton)
    }
    
    @objc private func cartButtonTapped() {
        if (self.cartCount > 0) {
            self.performSegue(withIdentifier: HomeToCartSegueIdentifier, sender: nil)
        } else {
            DisplayAlertView.shared.displayAlertView(title: EmptyCartTitle, message: EmptyCart, viewController: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? PlaceOrderViewController {
            destinationVC.cartModel = self.selectedModel
        }
        

    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, ViewModelProtocol, HomeCellDelegate, UISearchBarDelegate, UISearchDisplayDelegate{
    
    func isModelAssociatedWithValues(status: Bool) {
        if status {
            self.setUpCollectionViewDelegates()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.actualModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: UICollectionViewCell!
        if let cell_ = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCellIdentifier, for: indexPath) as? HomeCollectionViewCell {
            
            let currentModel = self.actualModel[indexPath.row]
            cell_.delegate = self
            cell_.populateValues(model: currentModel, indexPath: indexPath, selectedModel: self.selectedModel)
            cell = cell_
        }
        
        return cell
        
    }
    
    func didSelectItemButton(indexPathRow: Int, isSelected: Bool, beerId: Int) {
        
        let currentModel = self.actualModel[indexPathRow]
        
        if (isSelected) {
            
            currentModel.isSelected = true
            self.selectedModel.append(currentModel)
            self.cartCount = self.cartCount + 1

        } else {
            currentModel.isSelected = false
            let filteredIndices = self.selectedModel.indices.filter {self.selectedModel[$0].id == currentModel.id}
            self.selectedModel.remove(at: filteredIndices.startIndex)
            self.cartCount = self.cartCount - 1
            
        }
        
        self.addBadge(itemvalue: String(self.cartCount))
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchBarText = searchText
        self.reloadCollectionViewData(searchText: searchText)
    }
    
    func reloadCollectionViewData(searchText: String) {
        let searchString = searchText.trimWhiteSpace()
        if searchString != "", searchString.count > 0 {
            var filterData = self.viewModel.model.filter {
                return $0.name?.range(of: searchString, options: .caseInsensitive) != nil
            }
            self.actualModel.removeAll()
            filterData = filterData.sorted { (modelItem1, modelItem2) -> Bool in
                
                let Obj1_Name = modelItem1.name ?? ""
                let Obj2_Name = modelItem2.name ?? ""
                return (Obj1_Name.localizedCaseInsensitiveCompare(Obj2_Name) == .orderedAscending)
            }
            self.actualModel = filterData
            self.rootCollectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.reloadCollectionViewData(searchText: searchBar.text!)

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.actualModel.removeAll()
        self.actualModel = self.viewModel.model
        self.rootCollectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBarText = ""
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        let searchString = self.searchBarText.trimWhiteSpace()
        if searchString == "", searchString.count == 0 {
            self.actualModel.removeAll()
            self.actualModel = self.viewModel.model
            self.rootCollectionView.reloadData()
        }
        
    }
    
}


extension String {
    func trimWhiteSpace() -> String {
        let string = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return string
    }
}

