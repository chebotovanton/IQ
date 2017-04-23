//
//  ParseUtil.swift
//  IQ
//
//  Created by Anton Chebotov on 23/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class ParseUtil: NSObject {

    static func purchaseArray(_ array: [[String : Any]]) -> [Purchase] {
        var result: [Purchase] = []
        for dict in array {
            if let purchase = purchase(dict) {
                result.append(purchase)
            }
        }

        return result
    }

    static func purchase(_ dict: [String : Any]) -> Purchase? {
        let purchaseId = dict["id"] as? Int ?? 0
        let price = dict["cost"] as? Int ?? 0
        let refund = dict["refunded"] as? Int ?? 0
        let status = dict["status"] as? String ?? ""
        if let partnerDict = dict["partner"] as? [String : Any] {
            let name = partnerDict["name"] as? String ?? ""
            let iconUrlTail = partnerDict["logotypeUrl"] as? String ?? ""
            let iconUrl = StringUtils.kBaseUrl + iconUrlTail
            let purchase = Purchase(purchaseId: purchaseId, name: name, price: price, refund: refund, iconUrlString: iconUrl, status: status)
            
            return purchase
        }

        return nil
    }

}
