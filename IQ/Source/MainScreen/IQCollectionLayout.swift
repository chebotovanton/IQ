//
//  IQCollectionlayout.swift
//  IQ
//
//  Created by Anton Chebotov on 18/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class IQCollectionLayout: UICollectionViewLayout {

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
                    height += 50
                }
            }
        }
        return CGSize(width: width, height: height)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var result:[UICollectionViewLayoutAttributes] = []
        let yOffset = max(collectionView?.contentOffset.y ?? 0, 0)

        if let collectionView = collectionView {
            for section in 0 ..< collectionView.numberOfSections {
                for item in 0 ..< collectionView.numberOfItems(inSection: section) {
                    if section == 0 {
                        let attr = firstSectionAttr(item, offset: yOffset)
                        result.append(attr)
                    } else if section == 1 {
                        let attr = secondSectionAttr(item, offset: yOffset)
                        result.append(attr)
                    } else {
                        let attr = lastSectionAttr(item, offset: yOffset)
                        result.append(attr)
                    }
                }
            }
        }
        return result
    }

    private func firstSectionAttr(_ item: Int, offset: CGFloat) -> UICollectionViewLayoutAttributes {
        let indexPath = IndexPath(item: item, section: 0)
        let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let y = item * (50 - min(Int(offset), 30))
        attr.frame = CGRect(x: 0, y: y, width: 300, height: 40)
        attr.zIndex = item
        attr.alpha = (50 - offset) / 50.0

        return attr
    }

    private func secondSectionAttr(_ item: Int, offset: CGFloat) -> UICollectionViewLayoutAttributes {
        let indexPath = IndexPath(item: item, section: 1)
        let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let previousSectionsHeight = 100
        let y = previousSectionsHeight + max(item * (50 - Int(offset)), 0)
        attr.frame = CGRect(x: 0, y: y, width: 300, height: 40)
        attr.zIndex = 100 - item

        return attr
    }

    private func lastSectionAttr(_ item: Int, offset: CGFloat) -> UICollectionViewLayoutAttributes {
        let indexPath = IndexPath(item: item, section: 2)
        let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let previousSectionsHeight = 200
        let y = previousSectionsHeight + item * 50 - Int(offset)
        attr.frame = CGRect(x: 0, y: y, width: 300, height: 40)
        attr.zIndex = 100 - item

        return attr
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return collectionView?.contentOffset.y ?? 0 > 0
    }

}
