//
//  DisplayAlertView.swift
//  FalabellaiOS
//
//  Created by Rajagopal Ganesan on 21/07/19.
//  Copyright © 2019 Rajagopal Ganesan. All rights reserved.
//

import UIKit

class DisplayAlertView: NSObject {
    
    static let shared = DisplayAlertView()
    
    func displayAlertView(title: String, message: String, viewController: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }

}
