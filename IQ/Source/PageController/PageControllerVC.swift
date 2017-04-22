//
//  PageControllerVC.swift
//  IQ
//
//  Created by Anton Chebotov on 22/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class PageControllerVC: UIViewController, UIScrollViewDelegate, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var contentScroll: UIScrollView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var buttonView: UIView!
    @IBOutlet private weak var buttonViewBottom: NSLayoutConstraint!

    private let boosterAnimator = BoosterAnimator()

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

    @IBAction func openBoosterScreen() {
        let boosterVC = BoosterVC(nibName: "BoosterVC", bundle: nil)
        boosterVC.definesPresentationContext = true
        boosterVC.modalPresentationStyle = .overCurrentContext
        boosterVC.providesPresentationContextTransitionStyle = true;

        boosterVC.transitioningDelegate = self
        present(boosterVC, animated: true, completion: nil)
    }

    // MARK: - UIScrollViewDelegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > view.frame.width / 2.0 {
            pageControl.currentPage = 1
        } else {
            pageControl.currentPage = 0
        }

        var progress = scrollView.contentOffset.x / view.frame.width
        progress = min(1.0, progress)
        progress = max(progress, 0.0)

        buttonViewBottom.constant = -buttonView.frame.height * progress
    }

    //MARK: - UIViewControllerTransitioningDelegate

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return boosterAnimator
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return boosterAnimator
    }
}
