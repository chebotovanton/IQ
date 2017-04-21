//
//  MainVC.swift
//  IQ
//
//  Created by Anton Chebotov on 15/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CAAnimationDelegate {

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
            result.append(Purchase(name: "In progress " + String(i), progress: 0.1))
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

    @IBAction func openBrowser() {
        let browser = BrowserVC()
        navigationController?.pushViewController(browser, animated: true)
    }

    @IBAction func coinAction() {
        guard let doneCollection = doneCollection else { return }
        // WARNING: Weird coin y const
        let coinDestY = (doneCollection.layoutAttributesForItem(at: IndexPath(item: 0, section: 1))?.frame.origin.y)! - doneCollection.contentOffset.y + 70.0
        for _ in 0...5 {
            let coin = UIView()
            let x = CGFloat(arc4random_uniform(300))
            coin.frame = CGRect(x: x, y: 600, width: 20, height: 20)
            coin.layer.cornerRadius = 10.0
            coin.backgroundColor = Colors.progressColor()
            view.addSubview(coin)
            coins.append(coin)
        }

        for i in 0..<coins.count {
            let animation = CAKeyframeAnimation(keyPath: "position")
            let coin = coins[i]
            if i == 0 {
                // WARNING: Kekeke. Do a real delegate, moron!
                animation.delegate = self
            }
            animation.calculationMode = kCAAnimationPaced
            animation.fillMode = kCAFillModeForwards
            animation.path = coinPath(coin, destY: coinDestY)
            animation.duration = 2.0
            animation.beginTime = CACurrentMediaTime() + CFTimeInterval(0.2 * CGFloat(i))
            animation.isRemovedOnCompletion = true
            animation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn)

            coin.layer.add(animation, forKey: "anim")
        }
    }

    private func coinPath(_ coin: UIView, destY: CGFloat) -> CGPath {
        let originPoint = coin.center
        let destinationPoint = CGPoint(x: 50, y: destY)
        let path = sinPath(p1: originPoint, p2: destinationPoint)

        return path
    }

    private func sinPath(p1: CGPoint, p2: CGPoint) -> CGPath {
        // Calculate the transform
        let dx = p2.x - p1.x
        let dy = p2.y - p1.y
        let d = sqrt(dx * dx + dy * dy)
        let a = atan2(dy, dx)
        let cosa = cos(a)
        let sina = sin(a)

        let amplitude: CGFloat = CGFloat(arc4random_uniform(100)) / 50.0

        // Initialise our path
        let path = CGMutablePath()
        path.move(to: p1)

        // Plot a parametric function with 100 points
        let nPoints = 100
        for t in 0 ... nPoints {
            // Calculate the un-transformed x,y
            let tx = CGFloat(t) / CGFloat(nPoints) // 0 ... 1
            let ty = 0.1 * sin(amplitude * pow(tx, 1.0) * CGFloat.pi ) // 0 ... 2π, arbitrary amplitude
            // Apply the transform
            let x = p1.x + d * (tx * cosa - ty * sina)
            let y = p1.y + d * (tx * sina + ty * cosa)
            // Add the transformed point to the path
            path.addLine(to: CGPoint(x: x, y: y))
        }

        return path
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

    // MARK: - CAAnimationDelegate

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        for coin in self.coins {
            coin.layer.removeAllAnimations()
            coin.removeFromSuperview()
        }
        coins = []
        if let purchase = self.sections[1].purchases.first {
            purchase.progress = min(1, purchase.progress + 0.25)
            if purchase.progress == 1 {
                self.sections[1].purchases.remove(at: 0)
                self.sections[0].purchases.append(purchase)
                let indexToInsert = IndexPath(item: self.sections[0].purchases.count - 1, section: 0)
                let indexToRemove = IndexPath(item: 0, section: 1)
                self.doneCollection.performBatchUpdates({
                    self.doneCollection.insertItems(at: [indexToInsert])
                    self.doneCollection.deleteItems(at: [indexToRemove])
                }, completion: nil)
            } else {
                let indexToUpdate = IndexPath(item: 0, section: 1)
                if let purchaseCell = doneCollection.cellForItem(at: indexToUpdate) as? PurchaseCell {
                    purchaseCell.setup(purchase, animated: true)
                }
            }
        }
    }
}
