//
//  BoxModelDemoApp.swift
//  BoxModelDemo
//
//  Created by Maks Winters on 27.10.2023.
//
// https://posturereminderapp.com/blog/object-recognition-with-coreml-vision-and-swiftui-on-ios/
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
