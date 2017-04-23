//
//  PurchasesLoader.swift
//  IQ
//
//  Created by Anton Chebotov on 23/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

protocol PurchasesLoaderDelegate: NSObjectProtocol {
    func didLoadPurchases(_ purchases: [Purchase])
    func didFailLoadingPurchases()
}

class PurchasesLoader: NSObject {

    weak var delegate: PurchasesLoaderDelegate?

    func loadPayments() {
        let urlString = StringUtils.kBaseUrl + "/api/payments"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue(StringUtils.kAuthKey, forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 15

        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if let unwrappedData = data {
                self.parse(unwrappedData)
            } else {
                self.delegate?.didFailLoadingPurchases()
            }

        })
        task.resume()
    }

    func parse(_ data: Data) {
        do {
            let parsedData = try JSONSerialization.jsonObject(with: data, options: [])
            if let dict = parsedData as? [String : Any] {
                if let emb = dict["_embedded"] as? [String : Any] {
                    if let items = emb["items"] as? [[String : Any]] {
                        let result: [Purchase] = ParseUtil.purchaseArray(items)
                        self.delegate?.didLoadPurchases(result)
                    }
                }
            }
            self.delegate?.didFailLoadingPurchases()
        }
        catch {
            delegate?.didFailLoadingPurchases()
        }
    }
}
