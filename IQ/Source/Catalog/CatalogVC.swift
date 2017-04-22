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

        result.append(CatalogItem(name: "Timberland", price: "$179.95", icon: UIImage(named: "timberland")!, urlString: "https://www.groupon.com/deals/gs-timberland-men-s-waterproof-6-inch-classic-boot"))

        result.append(CatalogItem(name: "Ray-Ban Classic", price: "$150, CashBack $70", icon: UIImage(named: "rayban")!, urlString: "https://www.groupon.com/deals/gs-ray-ban-classic-clubmaster-for-women-and-men"))

        result.append(CatalogItem(name: "Xbox One 500GB", price: "$325, CashBack $105", icon: UIImage(named: "xbox")!, urlString: "https://www.groupon.com/deals/gg-xbox-one-with-forza-5-game"))

        result.append(CatalogItem(name: "NHL Wine Glasses", price: "$35, CashBack 40%", icon: UIImage(named: "nhl")!, urlString: "https://www.groupon.com/deals/gg-nhl-wine-glasses-2-pack"))

        result.append(CatalogItem(name: "15 Bottles of Wine", price: "$340, CashBack 81%", icon: UIImage(named: "wine")!, urlString: "https://www.groupon.com/deals/gg-wine-insiders-15-bottles-of-wine"))

        let icon = UIImage(named: "nike")!
        let urlString = "https://afisha.yandex.ru/saint-petersburg/cinema?preset=today"
            result.append(CatalogItem(name: "NIKE N-95", price: "$240, CashBack 40%", icon: icon, urlString: urlString))

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
