//
//  PurchaseUpdater.swift
//  IQ
//
//  Created by Anton Chebotov on 23/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

protocol PurchaseUpdaterDelegate: NSObjectProtocol {
    func didUpdatePurchases(_ new: [Purchase], toUpdate: [Purchase])
    func didFailUpdating()
}

class PurchaseUpdater: NSObject {

    weak var delegate: PurchaseUpdaterDelegate?

    func updatePayments() {
        let urlString = StringUtils.kBaseUrl + "/api/payments-recent"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue(StringUtils.kAuthKey, forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 15

        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if let unwrappedData = data {
                self.parse(unwrappedData)
            } else {
                self.delegate?.didFailUpdating()
            }

        })
        task.resume()
    }

    func parse(_ data: Data) {
        do {
            let parsedData = try JSONSerialization.jsonObject(with: data, options: [])
            if let dict = parsedData as? [String : Any] {
                if let emb = dict["_embedded"] as? [String : Any] {
                    if let items = emb["items"] as? [String : Any] {
                        var new: [Purchase] = []
                        var toUpdate: [Purchase] = []
                        if let newArray = items["new"] as? [[String : Any]] {
                            new = purchaseArray(newArray)
                        }
                        if let toUpdateArray = items["cashBackTo"] as? [[String : Any]] {
                            toUpdate = purchaseArray(toUpdateArray)
                        }
                        self.delegate?.didUpdatePurchases(new, toUpdate: toUpdate)
                    }
                }
            }
            self.delegate?.didFailUpdating()
        }
        catch {
            self.delegate?.didFailUpdating()
        }
    }

    private func purchaseArray(_ array: [[String : Any]]) -> [Purchase] {
        var result: [Purchase] = []
        for dict in array {
            if let purchase = purchase(dict) {
                result.append(purchase)
            }
        }

        return result
    }

    private func purchase(_ dict: [String : Any]) -> Purchase? {
        let purchaseId = dict["id"] as? Int ?? 0
        let price = dict["cost"] as? Int ?? 0
        let refund = dict["refunded"] as? Int ?? 0
        if let partnerDict = dict["partner"] as? [String : Any] {
            let name = partnerDict["name"] as? String ?? ""
            let iconUrlTail = partnerDict["logotypeUrl"] as? String ?? ""
            let iconUrl = StringUtils.kBaseUrl + iconUrlTail
            let purchase = Purchase(purchaseId: purchaseId, name: name, price: price, refund: refund, iconUrlString: iconUrl)
            return purchase
        }

        return nil
    }
}
