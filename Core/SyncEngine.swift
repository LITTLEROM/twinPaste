//
//  SyncEngine.swift
//  twinPaste
//
//  Created by Romain on 07/02/2026.
//

import Foundation

final class SyncEngine {

    func handleURLChange(_ url: URL) -> InjectionInstruction {
        return InjectionInstruction(
            selector: "input",
            value: url.absoluteString
        )
    }
}

