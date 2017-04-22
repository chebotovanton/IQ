//
//  IQCollectionlayout.swift
//  IQ
//
//  Created by Anton Chebotov on 18/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

protocol SectionsDelegate: NSObjectProtocol {
    func section(_ index: Int) -> Section
}

import UIKit

class IQCollectionLayout: UICollectionViewLayout {

    weak var sectionsDelegate: SectionsDelegate?

    private let kCellHeight: CGFloat = 76.0
    private let kHorizontalOffset: CGFloat = 20.0
    private let kBeetweenCellsSpace: CGFloat = 0.0
    private let kMinCollapsedCellHeight: CGFloat = 56.0
    private let kHeaderHeight: CGFloat = 66.0

    //WARNING: Weird workaround to set initial whitebackground visible
    private var contentSize: CGFloat = 1000
    private var backgroundView = UIView()

    override func prepare() {
        super.prepare()

        collectionView?.addSubview(backgroundView)
        collectionView?.sendSubview(toBack: backgroundView)
        backgroundView.layer.zPosition = -1000
        backgroundView.backgroundColor = Colors.whiteBackgroundColor()
    }

    override var collectionViewContentSize: CGSize {
        let width: CGFloat = collectionView?.frame.size.width ?? 0

        return CGSize(width: width, height: contentSize + 70.0)
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var result:[UICollectionViewLayoutAttributes] = []
        let yOffset = max(collectionView?.contentOffset.y ?? 0, 0)
        var heightSum: CGFloat = 0
        var firstSectionHeight: CGFloat = 0
        var firstAndSecondSectionHeight: CGFloat = 0

        if let collectionView = collectionView {
            for section in 0 ..< collectionView.numberOfSections {
                let purchaseSection = sectionsDelegate?.section(section)

                let headerAttr = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: IndexPath(item: 0, section: section))
                let headerY: CGFloat
                if purchaseSection?.layoutStyle == .done {
                    let offsetLim = min(yOffset, firstSectionScrollLim() + firstSectionHeight)
                    headerY = max(offsetLim, heightSum + offsetLim)
                } else if purchaseSection?.layoutStyle == .progress {
                    headerY = max(heightSum, yOffset)
                    //WARNING: wrong position
                    backgroundView.frame = CGRect(x: 0, y: headerY + kHeaderHeight * 1.5, width: collectionView.frame.width, height: contentSize)
                } else {
                    headerY = max(heightSum, yOffset)
                }
                headerAttr.frame = CGRect(x: 0,
                                          y: headerY,
                                          width: collectionView.frame.width,
                                          height: kHeaderHeight)
                heightSum = headerAttr.frame.maxY
                result.append(headerAttr)

                for item in 0 ..< collectionView.numberOfItems(inSection: section) {
                    let indexPath = IndexPath(item: item, section: section)
                    if purchaseSection?.layoutStyle == .done {
                        let attr = doneSectionAttr(indexPath, offset: yOffset, heightSum: heightSum)
                        heightSum = attr.frame.maxY + kBeetweenCellsSpace
                        firstSectionHeight = attr.frame.maxY + kBeetweenCellsSpace
                        result.append(attr)
                    } else if purchaseSection?.layoutStyle == .progress {
                        let attr = progressSectionAttr(indexPath, offset: yOffset, heightSum: heightSum, firstSectionHeight: firstSectionHeight)
                        heightSum = attr.frame.maxY + kBeetweenCellsSpace
                        firstAndSecondSectionHeight += kBeetweenCellsSpace + kHeaderHeight
                        result.append(attr)
                    } else if purchaseSection?.layoutStyle == .queue {
                        let attr = queueSectionAttr(indexPath, offset: yOffset, heightSum: heightSum)
                        result.append(attr)
                    }
                }
            }
        }
        return result
    }

    private func doneSectionAttr(_ indexPath: IndexPath, offset: CGFloat, heightSum: CGFloat) -> UICollectionViewLayoutAttributes {
        let height = kCellHeight + kBeetweenCellsSpace
        var collapseProgress: CGFloat = (offset - height * CGFloat(indexPath.item - 1)) / height
        collapseProgress = min(1, collapseProgress)
        collapseProgress = max(collapseProgress, 0)
        let y: CGFloat
        if indexPath.item == 0 {
            y = heightSum
        } else {
            y = heightSum - kMinCollapsedCellHeight * collapseProgress
        }
        let attr = createAttr(y, indexPath: indexPath)
        attr.zIndex = indexPath.item

        return attr
    }

    private func progressSectionAttr(_ indexPath: IndexPath, offset: CGFloat, heightSum: CGFloat, firstSectionHeight: CGFloat) -> UICollectionViewLayoutAttributes {
        let height = kCellHeight + kBeetweenCellsSpace
        var collapseProgress: CGFloat = (offset - firstSectionHeight - height * CGFloat(indexPath.item - 1)) / height
        collapseProgress = min(1, collapseProgress)
        collapseProgress = max(collapseProgress, 0)
        let y: CGFloat
        if indexPath.item == 0 {
            y = heightSum
        } else {
            y = heightSum - kMinCollapsedCellHeight * collapseProgress
        }
        let attr = createAttr(y, indexPath: indexPath)
        attr.zIndex = 100 - indexPath.item

        return attr
    }

    private func queueSectionAttr(_ indexPath: IndexPath, offset: CGFloat, heightSum: CGFloat) -> UICollectionViewLayoutAttributes {
        let height = kCellHeight + kBeetweenCellsSpace
        let totalSum: CGFloat = secondSectionScrollLim()
        let y: CGFloat = max(totalSum + height * CGFloat(indexPath.item), heightSum - kHeaderHeight)
        let attr = createAttr(y, indexPath: indexPath)
        contentSize = attr.frame.maxY
        attr.zIndex = -200

        return attr
    }

    private func createAttr(_ y: CGFloat, indexPath: IndexPath) -> UICollectionViewLayoutAttributes {
        let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attr.frame = CGRect(x: kHorizontalOffset,
                            y: y,
                            width: (collectionView?.frame.width)! - 2 * kHorizontalOffset,
                            height: kCellHeight)

        return attr
    }

    private func firstSectionScrollLim() -> CGFloat {
        guard let collectionView = collectionView else { return 0.0 }
        let count = CGFloat(collectionView.numberOfItems(inSection: 0))
        let height = kCellHeight + kBeetweenCellsSpace
        return height + (count - 1) * kMinCollapsedCellHeight
    }

    private func secondSectionScrollLim() -> CGFloat {
        guard let collectionView = collectionView else { return 0.0 }
        let countFloat = CGFloat(collectionView.numberOfItems(inSection: 0) + collectionView.numberOfItems(inSection: 1)) + 1
        let height = kCellHeight + kBeetweenCellsSpace
        let result = height * countFloat + (countFloat - 2) * kMinCollapsedCellHeight

        return result
    }

}
