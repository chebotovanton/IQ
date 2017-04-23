//
//  HowItWorks.swift
//  IQ
//
//  Created by Anton Chebotov on 23/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class HowItWorks: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(image: UIImage(named: "Article")!)
        imageView.frame = CGRect(x: 0, y: 0, width: 375, height: 970)
        scrollView.addSubview(imageView)
        scrollView.contentSize = CGSize(width: 375, height: 970)
    }

    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }

}
