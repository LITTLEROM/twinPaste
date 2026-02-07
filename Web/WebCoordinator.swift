//
//  WebCoordinator.swift
//  twinPaste
//
//  Created by Romain on 07/02/2026.
//

import WebKit

final class WebCoordinator: NSObject, WKNavigationDelegate {

    var onURLChange: ((URL) -> Void)?

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let url = webView.url {
            onURLChange?(url)
        }
    }
}

