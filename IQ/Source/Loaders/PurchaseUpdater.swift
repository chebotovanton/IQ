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
                            new = ParseUtil.purchaseArray(newArray)
                            notifyServer(new)
                        }
                        if let toUpdateArray = items["cashBackTo"] as? [[String : Any]] {
                            toUpdate = ParseUtil.purchaseArray(toUpdateArray)
                            notifyServer(toUpdate)
                        }
                        DispatchQueue.main.async(execute: {
                            self.delegate?.didUpdatePurchases(new, toUpdate: toUpdate)
                        })
                    }
                }
            }
            self.delegate?.didFailUpdating()
        }
        catch {
            self.delegate?.didFailUpdating()
        }
    }

    private func notifyServer(_ purchaseArray: [Purchase]) {
        for purchase in purchaseArray {
            func updatePayments() {
                let urlString = StringUtils.kBaseUrl + "/api/payments-recent" + String(purchase.purchaseId)
                let url = URL(string: urlString)!
                var request = URLRequest(url: url)
                request.httpMethod = "PATCH"
                request.setValue(StringUtils.kAuthKey, forHTTPHeaderField: "Authorization")
                request.timeoutInterval = 15

                let dict = ["isShown" : true]
                do {
                    let data = try JSONSerialization.data(withJSONObject: dict, options: [])
                    request.httpBody = data

                    let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                    })
                    task.resume()
                }
                catch {}
            }
        }
    }
}
