//
//  JSONStore.swift
//  twinPaste
//
//  Created by Romain on 07/02/2026.
//

import Foundation

final class JSONStore {

    static let shared = JSONStore()
    private init() {}

    private let fileName = "config.json"

    private var fileURL: URL {
        let baseURL = FileManager.default.urls(
            for: .applicationSupportDirectory,
            in: .userDomainMask
        ).first!

        let appFolder = baseURL.appendingPathComponent("twinPaste", isDirectory: true)

        if !FileManager.default.fileExists(atPath: appFolder.path) {
            try? FileManager.default.createDirectory(
                at: appFolder,
                withIntermediateDirectories: true
            )
        }

        return appFolder.appendingPathComponent(fileName)
    }

    func load() -> AppState {

        let url = fileURL

        if let data = try? Data(contentsOf: url),
           let decoded = try? JSONDecoder().decode(AppState.self, from: data) {
            return decoded
        }

        let defaultState = AppState.default
        save(defaultState)
        return defaultState
    }


    func save(_ state: AppState) {
        let url = fileURL
        if let data = try? JSONEncoder().encode(state) {
            try? data.write(to: url, options: .atomic)
        }
    }
}
