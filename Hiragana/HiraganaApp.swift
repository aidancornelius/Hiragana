//
//  HiraganaApp.swift
//  Hiragana
//
//  Created by Aidan Cornelius-Bell on 29/8/2025.
//

import SwiftUI

@main
struct HiraganaApp: App {
    @StateObject private var gameViewModel = GameViewModel()
    @StateObject private var settingsViewModel = SettingsViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameViewModel)
                .environmentObject(settingsViewModel)
        }
    }
}
