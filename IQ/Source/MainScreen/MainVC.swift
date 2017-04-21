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

    private var coins: [UIView] = []

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
        var result: [Purchase] = []
        for i in 0...4 {
            result.append(Purchase(name: "Done " + String(i), progress: 1))
        }
        setFakeIcons(result)

        return result
    }

    private func createFakeProgressItems() -> [Purchase] {
        var result: [Purchase] = []
        for i in 0...4 {
            result.append(Purchase(name: "In progress " + String(i), progress: 0.5))
        }
        setFakeIcons(result)

        return result
    }

    private func createFakeQueueItems() -> [Purchase] {
        var result: [Purchase] = []
        for i in 0...6 {
            result.append(Purchase(name: "In queue " + String(i), progress: 0))
        }
        setFakeIcons(result)

        return result
    }

    private func setFakeIcons(_ items: [Purchase]) {
        for i in 0..<items.count {
            let purchase = items[i]
            let iconName = "logo" + String(i)
            purchase.icon = UIImage(named: iconName)
        }
    }

    //MARK: - Actions

    @IBAction func coinAction() {
        guard let doneCollection = doneCollection else { return }
        // WARNING: Weird coin y const
        let coinDestY = (doneCollection.layoutAttributesForItem(at: IndexPath(item: 0, section: 1))?.frame.origin.y)! - doneCollection.contentOffset.y + 70.0
        for _ in 0...5 {
            let coin = UIView()
            let x = CGFloat(arc4random_uniform(300))
            coin.frame = CGRect(x: x, y: 800, width: 20, height: 20)
            coin.layer.cornerRadius = 10.0
            coin.backgroundColor = Colors.progressColor()
            view.addSubview(coin)
            coins.append(coin)
        }
//        UIView.animate(withDuration: 1.5, animations: {
            for coin in self.coins {
                let animation = CAKeyframeAnimation(keyPath: "position")
                animation.calculationMode = kCAAnimationPaced
                animation.fillMode = kCAFillModeForwards
                animation.path = coinPath(coin, destY: coinDestY)
                animation.duration = 2.0
                animation.isRemovedOnCompletion = false
                animation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn)

                coin.layer.add(animation, forKey: "anim")
            }
//        }) { (finished) in
//            for coin in self.coins {
//                coin.removeFromSuperview()
//            }
//            if let purchase = self.sections[1].purchases.first {
//                purchase.progress = min(1, purchase.progress + 0.1)
//                if purchase.progress == 1 {
//                    self.sections[1].purchases.remove(at: 0)
//                    self.sections[0].purchases.append(purchase)
//                    let indexToInsert = IndexPath(item: self.sections[0].purchases.count - 1, section: 0)
//                    let indexToRemove = IndexPath(item: 0, section: 1)
//                    self.doneCollection.performBatchUpdates({
//                        self.doneCollection.insertItems(at: [indexToInsert])
//                        self.doneCollection.deleteItems(at: [indexToRemove])
//                    }, completion: nil)
//                } else {
//                    let indexToUpdate = IndexPath(item: 0, section: 1)
//                    self.doneCollection.reloadItems(at: [indexToUpdate])
//                }
//            }
    }

    private func coinPath(_ coin: UIView, destY: CGFloat) -> CGPath {
        let path = UIBezierPath()
        let originPoint = coin.center
        let xDelta = CGFloat(arc4random_uniform(300)) - 150.0
        let controlPoint = CGPoint(x: coin.frame.origin.x + xDelta, y: (destY + coin.frame.origin.y) / 2.0)
        let destinationPoint = CGPoint(x: coin.center.x, y: destY)
        path.move(to: originPoint)
        path.addQuadCurve(to: destinationPoint, controlPoint: controlPoint)

        return path.cgPath
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        let purchase = section.purchases[indexPath.item]

        let detailsVC = PurchaseDetailsVC(nibName: "PurchaseDetailsVC", bundle: nil)
        detailsVC.purchase = purchase

        detailsVC.definesPresentationContext = true
        detailsVC.modalPresentationStyle = .overCurrentContext
        detailsVC.providesPresentationContextTransitionStyle = true;

        present(detailsVC, animated: true, completion: nil)
    }
}
