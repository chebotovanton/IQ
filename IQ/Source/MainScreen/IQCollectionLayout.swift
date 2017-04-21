//
//  IQCollectionlayout.swift
//  IQ
//
//  Created by Anton Chebotov on 18/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class IQCollectionLayout: UICollectionViewLayout {

    private let kCellHeight: CGFloat = 76.0
    private let kHorizontalOffset: CGFloat = 20.0
    private let kBeetweenCellsSpace: CGFloat = 0.0
    private let kMinCollapsedCellHeight: CGFloat = 56.0
    private let kHeaderHeight: CGFloat = 66.0

    private var contentSize: CGFloat = 0

    private var backgroundView = UIView()

    override func prepare() {
        super.prepare()

        collectionView?.addSubview(backgroundView)
        collectionView?.sendSubview(toBack: backgroundView)
        backgroundView.backgroundColor = Colors.whiteBackgroundColor()
    }

    override var collectionViewContentSize: CGSize {
        let width: CGFloat = collectionView?.frame.size.width ?? 0

        return CGSize(width: width, height: contentSize)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var result:[UICollectionViewLayoutAttributes] = []
        let yOffset = max(collectionView?.contentOffset.y ?? 0, 0)
        var heightSum: CGFloat = 0
        var firstSectionHeight: CGFloat = 0
        var firstAndSecondSectionHeight: CGFloat = 0

        if let collectionView = collectionView {
            for section in 0 ..< collectionView.numberOfSections {
                let headerAttr = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: IndexPath(item: 0, section: section))
                let headerY: CGFloat
                if section == 0 {
                    let offsetLim = min(yOffset, 200 + firstSectionHeight)
                    headerY = max(offsetLim, heightSum + offsetLim)
                } else if section == 1 {
                    headerY = max(heightSum, yOffset)
                    backgroundView.frame = CGRect(x: 0, y: headerY + kHeaderHeight * 1.5, width: collectionView.frame.width, height: 2000)
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
                    if section == 0 {
                        let attr = firstSectionAttr(item, offset: yOffset, heightSum: heightSum)
                        heightSum = attr.frame.maxY + kBeetweenCellsSpace
                        firstSectionHeight = attr.frame.maxY + kBeetweenCellsSpace
                        result.append(attr)
                    } else if section == 1 {
                        let attr = secondSectionAttr(item, offset: yOffset, heightSum: heightSum, firstSectionHeight: firstSectionHeight)
                        heightSum = attr.frame.maxY + kBeetweenCellsSpace
                        firstAndSecondSectionHeight += kBeetweenCellsSpace + kHeaderHeight
                        result.append(attr)
                    } else if section == 2 {
                        let attr = lastSectionAttr(item, offset: yOffset, heightSum: heightSum)
                        result.append(attr)
                    }
                }
            }
        }
        return result
    }

    private func firstSectionAttr(_ item: Int, offset: CGFloat, heightSum: CGFloat) -> UICollectionViewLayoutAttributes {
        let height = kCellHeight + kBeetweenCellsSpace
        let indexPath = IndexPath(item: item, section: 0)
        var collapseProgress: CGFloat = (offset - height * CGFloat(item - 1)) / height
        collapseProgress = min(1, collapseProgress)
        collapseProgress = max(collapseProgress, 0)
        let y: CGFloat
        if item == 0 {
            y = heightSum
        } else {
            y = heightSum - kMinCollapsedCellHeight * collapseProgress
        }
        let attr = createAttr(y, indexPath: indexPath)
        attr.zIndex = item

        return attr
    }

    private func secondSectionAttr(_ item: Int, offset: CGFloat, heightSum: CGFloat, firstSectionHeight: CGFloat) -> UICollectionViewLayoutAttributes {
        let height = kCellHeight + kBeetweenCellsSpace
        let indexPath = IndexPath(item: item, section: 1)
        var collapseProgress: CGFloat = (offset - firstSectionHeight - height * CGFloat(item - 1)) / height
        collapseProgress = min(1, collapseProgress)
        collapseProgress = max(collapseProgress, 0)
        let y: CGFloat
        if item == 0 {
            y = heightSum
        } else {
            y = heightSum - kMinCollapsedCellHeight * collapseProgress
        }
        let attr = createAttr(y, indexPath: indexPath)
        attr.zIndex = 100 - item

        return attr
    }

    private func lastSectionAttr(_ item: Int, offset: CGFloat, heightSum: CGFloat) -> UICollectionViewLayoutAttributes {
        let height = kCellHeight + kBeetweenCellsSpace
        let indexPath = IndexPath(item: item, section: 2)
        let totalSum: CGFloat = CGFloat(10 * height)
        let y: CGFloat = max(totalSum + height * CGFloat(item), heightSum - kHeaderHeight)
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

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return collectionView?.contentOffset.y ?? 0 > 0
    }

}
