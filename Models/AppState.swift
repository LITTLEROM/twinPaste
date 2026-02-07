//
//  AppState.swift
//  twinPaste
//
//  Created by Romain on 07/02/2026.
//

import Foundation

struct AppState: Codable {
    var leftURL: String
    var rightURL: String

    static let `default` = AppState(
        leftURL: "https://example.com",
        rightURL: "https://example.org"
    )
}

