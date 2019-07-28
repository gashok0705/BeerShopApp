//
//  ApiController.swift
//  FalabellaiOS
//
//  Created by Rajagopal Ganesan on 21/07/19.
//  Copyright © 2019 Rajagopal Ganesan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ApiController: NSObject {
    
    static let shared = ApiController()
    
    func performRestAPI(url: String, viewController: UIViewController, restType: HTTPMethod, inputParams: [String: Any]?, completionHandler: @escaping ((_ error: Error?, _ responseDict: [[String: Any]]?) -> Void)) {
        
        DisplayActivitySpinner.shared.showActivityIndicatory(uiView: viewController.view)
        Alamofire.request(url, method: restType, parameters: inputParams,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            DispatchQueue.main.async { [weak viewController] in
                if let strongSelf = viewController {
                    DisplayActivitySpinner.shared.hideActivityIndicator()
                    switch response.result {
                    case .success(let jsonResp):
                        let swiftyJsonVar = JSON(jsonResp)
                        let dictionaryJson = ApiController.shared.convertToDictionary(text: swiftyJsonVar.rawString()!)
                        completionHandler(nil, dictionaryJson)
                        break
                        
                    case .failure(let encodingError ):
                        print(encodingError)
                        if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                            // no internet connection
                            DisplayAlertView.shared.displayAlertView(title: NoInternetTitle, message: NoInternetConnection, viewController: strongSelf)
                        } else {
                            // other failures
                            DisplayAlertView.shared.displayAlertView(title: NoInternetTitle, message: encodingError.localizedDescription, viewController: strongSelf)
                        }
                        completionHandler(encodingError, nil)
                    }
                }
            }
        }
    }
    
    private func convertToDictionary(text: String) -> [[String: Any]]? {
        if let data = text.data(using: .utf8) {
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
                {
                    return jsonArray
                } else {
                    return nil
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}
