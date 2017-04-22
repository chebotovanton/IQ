//
//  CatalogItem.swift
//  IQ
//
//  Created by Anton Chebotov on 22/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class CatalogItem: NSObject {
    let name: String
    let price: String
    let icon: UIImage
    let urlString: String

    init(name: String, price: String, icon: UIImage, urlString: String) {
        self.name = name
        self.price = price
        self.icon = icon
        self.urlString = urlString
    }
}
