//
//  CatalogVC.swift
//  IQ
//
//  Created by Anton Chebotov on 22/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class CatalogVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    private let kCellIdentifier = "CatalogCell"
    private let kHeaderIdentifier = "CatalogHeader"
    private var items: [CatalogItem] = []
    @IBOutlet private weak var offersCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        items = createFakeItems()
        offersCollection.register(UINib(nibName: kCellIdentifier, bundle: nil), forCellWithReuseIdentifier: kCellIdentifier)

        let headerNib = UINib(nibName: kHeaderIdentifier, bundle: nil)
        offersCollection.register(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderIdentifier)

    }

    private func createFakeItems() -> [CatalogItem] {
        var result: [CatalogItem] = []
        let icon = UIImage(named: "nike")!
        let urlString = "https://www.ebates.com/livingsocial_11445-xfas?special=11944400&sourceName=Web-Desktop"
        for _ in 0..<7 {
            result.append(CatalogItem(name: "NIKE N-95", price: "$240, CashBack 40%", icon: icon, urlString: urlString))
        }

        return result
    }

    //MARK: - UICollectionViewDelegate, UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier, for: indexPath)
        if let catalogCell = cell as? CatalogCell {
            let item = items[indexPath.item]
            catalogCell.setup(item)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        let browser = BrowserVC()
        browser.urlString = item.urlString
        navigationController?.pushViewController(browser, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderIdentifier, for: indexPath)

        if let header = view as? CatalogHeader {
            header.nameLabel.text = "Catalog"
        }

        return view
    }

    

}
