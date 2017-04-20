//
//  MainVC.swift
//  IQ
//
//  Created by Anton Chebotov on 15/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet private weak var doneCollection: UICollectionView!

    private var sections: [Section] = []
    private let kCellIdentifier = "PurchaseCell"
    private let kHeaderIdentifier = "HeaderView"

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: kCellIdentifier, bundle: nil)
        doneCollection.register(nib, forCellWithReuseIdentifier: kCellIdentifier)
        let headerNib = UINib(nibName: kHeaderIdentifier, bundle: nil)
        doneCollection.register(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderIdentifier)

        let doneLayout = IQCollectionLayout()
        doneCollection.collectionViewLayout = doneLayout
        doneCollection.alwaysBounceVertical = true

        sections = createSections()
    }

    //MARK: - Private

    private func createSections() -> [Section] {
        return [Section(createFakeDoneItems(), name: "Latest Returned"),
                Section(createFakeProgressItems(), name: "In Turn"),
                Section(createFakeQueueItems(), name: "Purchased")
        ]
    }

    private func createFakeDoneItems() -> [Purchase] {
        return [Purchase(name: "First Done", progress: 1),
                Purchase(name: "Second Done", progress: 1),
                Purchase(name: "Third Done", progress: 1)
        ]
    }

    private func createFakeProgressItems() -> [Purchase] {
        return [Purchase(name: "First in progress", progress: 0.5),
                Purchase(name: "Second in progress", progress: 0.1),
                Purchase(name: "Third in progress", progress: 0.1)
        ]
    }

    private func createFakeQueueItems() -> [Purchase] {
        var result: [Purchase] = []
        for i in 0...6 {
            result.append(Purchase(name: "In queue " + String(i), progress: 0))
        }
        return result
    }

    //MARK: - Actions

    @IBAction func coinAction() {
        if let purchase = sections[1].purchases.first {
            purchase.progress = min(1, purchase.progress + 0.1)
//            if purchase.progress == 1 {
//                progressItems.remove(at: 0)
//                doneItems.append(purchase)
//            }
            doneCollection.reloadData()
        }
    }

    //MARK: - UICollectionViewDelegate, UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].purchases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        let purchase = section.purchases[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier, for: indexPath) as! PurchaseCell
        cell.setup(purchase)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderIdentifier, for: indexPath)

        if let header = view as? HeaderView {
            let section = sections[indexPath.section]
            header.nameLabel?.text = section.name
            let black = (indexPath.section == sections.count - 1)
            header.setStyle(black: black)
        }

        return view
    }
}
