//
//  BoosterLoader.swift
//  IQ
//
//  Created by Anton Chebotov on 23/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

protocol BoosterLoaderDelegate: NSObjectProtocol {
    func boosterValueLoaded(_ value: Int)
}

import UIKit

class BoosterLoader: NSObject {

    weak var delegate: BoosterLoaderDelegate?

    func loadBoosterValue() {
        let urlString = StringUtils.kBaseUrl + "/api/balance"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue(StringUtils.kAuthKey, forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 15

        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if let unwrappedData = data {
                self.parse(unwrappedData)
            } else {
            }
        })
        task.resume()
    }

    func parse(_ data: Data) {
        do {
            let parsedData = try JSONSerialization.jsonObject(with: data, options: [])
            if let dict = parsedData as? [String : Any] {
                let amount = dict["amount"] as? Int ?? 0
                self.delegate?.boosterValueLoaded(amount)
            }
        }
        catch {}
    }

    func setBoosterValue(_ value: Int) {
        let urlString = StringUtils.kBaseUrl + "/api/balance"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue(StringUtils.kAuthKey, forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 15
        let dict = ["isBoosted" : 1, "amount" : value]
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
