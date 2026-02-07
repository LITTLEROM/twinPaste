//
//  ContentView.swift
//  twinPaste
//
//  Created by Romain on 07/02/2026.
//

import SwiftUI
import WebKit

struct ContentView: View {

    private let leftWebView: WKWebView
    private let rightWebView: WKWebView
    private let coordinator: WebCoordinator
    private let syncEngine: SyncEngine

    init() {
      

        print("ContentView init called")
        let left = WKWebView()
        let right = WKWebView()
        let coord = WebCoordinator()
        let engine = SyncEngine()

        // 🔥 Chargement du JSON au démarrage
        let state = JSONStore.shared.load()

        if let leftURL = URL(string: state.leftURL),
           let rightURL = URL(string: state.rightURL) {

            left.load(URLRequest(url: leftURL))
            right.load(URLRequest(url: rightURL))
        }

        coord.onURLChange = { [weak right] url in
            let instruction = engine.handleURLChange(url)

            let escapedValue = instruction.value
                .replacingOccurrences(of: "'", with: "\\'")
                .replacingOccurrences(of: "\n", with: "")

            let js = """
            const input = document.querySelector('\(instruction.selector)');
            if (input) {
                input.value = '\(escapedValue)';
                input.dispatchEvent(new Event('input', { bubbles: true }));
            }
            """

            right?.evaluateJavaScript(js)
        }

        left.navigationDelegate = coord

        self.leftWebView = left
        self.rightWebView = right
        self.coordinator = coord
        self.syncEngine = engine
    }

    var body: some View {
        HStack(spacing: 0) {
            WebView(webView: leftWebView)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            WebView(webView: rightWebView)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
