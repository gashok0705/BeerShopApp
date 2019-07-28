//
//  DisplayActivitySpinner.swift
//  FalabellaiOS
//
//  Created by Rajagopal Ganesan on 21/07/19.
//  Copyright © 2019 Rajagopal Ganesan. All rights reserved.
//

import UIKit

class DisplayActivitySpinner: NSObject {
    
    static let shared = DisplayActivitySpinner()

    var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    var container: UIView = UIView()
    
    func showActivityIndicatory(uiView: UIView) {
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        actInd.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
        actInd.style =
            UIActivityIndicatorView.Style.whiteLarge
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2,
                                y: loadingView.frame.size.height / 2);
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
    }
    
    func hideActivityIndicator()  {
        self.actInd.stopAnimating()
        self.container.removeFromSuperview()
        self.actInd.removeFromSuperview()
    }

}
