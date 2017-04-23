//
//  partnersLoader.swift
//  IQ
//
//  Created by Anton Chebotov on 23/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

protocol PartnersLoaderDelegate: NSObjectProtocol {
    func didLoadPartners(_ partners: [CatalogItem])
    func didFailLoadingPartners()
}

class PartnersLoader: NSObject {
    weak var delegate: PartnersLoaderDelegate?

    func loadPartners() {
        let urlString = StringUtils.kBaseUrl + "/api/partners"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue(StringUtils.kAuthKey, forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 15

        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if let unwrappedData = data {
                self.parse(unwrappedData)
            } else {
                self.delegate?.didFailLoadingPartners()
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
                        var result: [CatalogItem] = []
                        for itemDict in items {
                            let name = itemDict["name"] as? String ?? ""
                            let discount = itemDict["discount"] as? Int ?? 0
                            let iconUrlTail = itemDict["logotypeUrl"] as? String ?? ""
                            let iconUrl = StringUtils.kBaseUrl + iconUrlTail
                            let partnerUrl = itemDict["partnerUrl"] as? String ?? "https://afisha.yandex.ru/saint-petersburg/cinema?preset=today"
                            let catalogItem = CatalogItem(name: name, discount: discount, iconUrl: iconUrl, urlString: partnerUrl)
                            result.append(catalogItem)
                        }
                        self.delegate?.didLoadPartners(result)
                    }
                }
            }
            self.delegate?.didFailLoadingPartners()
        }
        catch {
            delegate?.didFailLoadingPartners()
        }
    }

}
