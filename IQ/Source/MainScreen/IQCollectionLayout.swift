//
//  IQCollectionlayout.swift
//  IQ
//
//  Created by Anton Chebotov on 18/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class IQCollectionLayout: UICollectionViewLayout {

    private let kCellHeight: CGFloat = 66.0
    private let kHorizontalOffset: CGFloat = 20.0
    private let kBeetweenCellsSpace: CGFloat = 10.0
    private let kMinCollapsedCellHeight: CGFloat = 56.0
    private let kHeaderHeight: CGFloat = 66.0

    override func prepare() {
        super.prepare()
    }

    override var collectionViewContentSize: CGSize {
        var width: CGFloat = 0
        var height: CGFloat = 0
        if let collectionView = collectionView {
            width = collectionView.frame.size.width
            for section in 0 ..< collectionView.numberOfSections {
                for _ in 0 ..< collectionView.numberOfItems(inSection: section) {
                    height += kHeaderHeight
                }
            }
        }
        return CGSize(width: width, height: height)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var result:[UICollectionViewLayoutAttributes] = []
        let yOffset = max(collectionView?.contentOffset.y ?? 0, 0)
        var heightSum: CGFloat = 0

        if let collectionView = collectionView {
            for section in 0 ..< collectionView.numberOfSections {
                let headerAttr = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: IndexPath(item: 0, section: section))
                headerAttr.frame = CGRect(x: 0,
                                          y: heightSum,
                                          width: collectionView.frame.width,
                                          height: kHeaderHeight)
                heightSum = headerAttr.frame.maxY
                result.append(headerAttr)

                for item in 0 ..< collectionView.numberOfItems(inSection: section) {
                    if section == 0 {
                        let attr = firstSectionAttr(item, offset: yOffset, heightSum: heightSum)
                        heightSum = attr.frame.maxY
                        result.append(attr)
                    } else if section == 1 {
                        let attr = secondSectionAttr(item, offset: yOffset, heightSum: heightSum)
                        heightSum = attr.frame.maxY
                        result.append(attr)
                    } else {
                        let attr = lastSectionAttr(item, offset: yOffset, heightSum: heightSum)
                        heightSum = attr.frame.maxY
                        result.append(attr)
                    }
                }
            }
        }
        return result
    }

    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attr = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: indexPath)
        attr.frame = CGRect(x: 0, y: 0, width: 300.0, height: kHeaderHeight)

        return attr
    }

    private func firstSectionAttr(_ item: Int, offset: CGFloat, heightSum: CGFloat) -> UICollectionViewLayoutAttributes {
        let height = kCellHeight + kBeetweenCellsSpace
        let indexPath = IndexPath(item: item, section: 0)
        let y = heightSum//kHeaderHeight + CGFloat(item) * (height - min(offset, kMinCollapsedCellHeight))
        let attr = createAttr(CGFloat(y), indexPath: indexPath)
        attr.zIndex = item
//        attr.alpha = (height - offset) / height

        return attr
    }

    private func secondSectionAttr(_ item: Int, offset: CGFloat, heightSum: CGFloat) -> UICollectionViewLayoutAttributes {
        let height = kCellHeight + kBeetweenCellsSpace
        let indexPath = IndexPath(item: item, section: 1)
        let previousSectionsHeight = kHeaderHeight * 2 +
            CGFloat(collectionView!.numberOfItems(inSection: 0)) * height
        let y = heightSum//previousSectionsHeight + CGFloat(item) * (height - min(offset, kMinCollapsedCellHeight))
        let attr = createAttr(CGFloat(y), indexPath: indexPath)
        attr.zIndex = 100 - item

        return attr
    }

    private func lastSectionAttr(_ item: Int, offset: CGFloat, heightSum: CGFloat) -> UICollectionViewLayoutAttributes {
        let indexPath = IndexPath(item: item, section: 2)
        let previousSectionsHeight = 800
        let y = heightSum//previousSectionsHeight + item * 50 - Int(offset)
        let attr = createAttr(CGFloat(y), indexPath: indexPath)
        attr.zIndex = 100 - item

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
