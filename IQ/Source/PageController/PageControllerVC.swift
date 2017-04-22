//
//  PageControllerVC.swift
//  IQ
//
//  Created by Anton Chebotov on 22/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class PageControllerVC: UIViewController {

    @IBOutlet weak var contentScroll: UIScrollView!
    private var catalogVC: CatalogVC!
    private var mainVC: MainVC!

    override func viewDidLoad() {
        super.viewDidLoad()

        catalogVC = CatalogVC(nibName: "CatalogVC", bundle: nil)
        mainVC = MainVC(nibName: "MainVC", bundle: nil)

        addChildViewController(catalogVC)
        addChildViewController(mainVC)

        let width = view.frame.width
        let height = contentScroll.frame.height
        contentScroll.contentSize = CGSize(width: width * 2.0, height: height)

        mainVC.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        catalogVC.view.frame = CGRect(x: width, y: 0, width: width, height: height)

        contentScroll.addSubview(mainVC.view)
        contentScroll.addSubview(catalogVC.view)
    }
}
