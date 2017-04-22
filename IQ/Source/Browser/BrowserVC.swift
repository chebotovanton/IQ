//
//  BrowserVC.swift
//  IQ
//
//  Created by Anton Chebotov on 21/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit
import WebKit

class BrowserVC: UIViewController, WKUIDelegate {

    private var webView: WKWebView!
    var urlString: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        let config = WKWebViewConfiguration()
        webView = WKWebView(frame: view.frame, configuration: config)
        webView.uiDelegate = self
        view.addSubview(webView)

        if let urlString = urlString {
            let url = URL(string: urlString)!
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        // A nil targetFrame means a new window (from Apple's doc)
        if (navigationAction.targetFrame == nil) {
            // Let's create a new webview on the fly with the provided configuration,
            // set us as the UI delegate and return the handle to the parent webview
            let popup = WKWebView(frame: self.view.frame, configuration: configuration)
            popup.uiDelegate = self
            self.view.addSubview(popup)
            return popup
        }
        return nil;
    }

    func webViewDidClose(webView: WKWebView) {
        // Popup window is closed, we remove it
        webView.removeFromSuperview()
    }
}
