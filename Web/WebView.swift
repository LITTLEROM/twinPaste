//
//  WebView.swift
//  twinPaste
//
//  Created by Romain on 07/02/2026.
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {

    let webView: WKWebView

    func makeNSView(context: Context) -> WKWebView {
        webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {}
}
