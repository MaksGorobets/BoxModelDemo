//
//  BoxModelDemoApp.swift
//  BoxModelDemo
//
//  Created by Maks Winters on 27.10.2023.
//

import SwiftUI

@main
struct BoxModelDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(classifier: ImageClassifier())
        }
    }
}
