//
//  SettingsViewModelTests.swift
//  HiraganaTests
//
//  Created by Aidan Cornelius-Bell on 29/8/2025.
//

import Testing
import SwiftUI
import Combine
@testable import Hiragana

@MainActor
struct SettingsViewModelTests {
    
    @Test("SettingsViewModel initialises with default values")
    func testInitialisation() {
        // Clear any existing defaults first
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "useBasicHiragana")
        defaults.removeObject(forKey: "useStandardHiragana")
        defaults.removeObject(forKey: "useIntermediateHiragana")
        defaults.removeObject(forKey: "useAdvancedHiragana")
        defaults.removeObject(forKey: "showHintButtons")
        
        let viewModel = SettingsViewModel()
        
        #expect(viewModel.useBasicHiragana == true)
        #expect(viewModel.useStandardHiragana == true)
        #expect(viewModel.useIntermediateHiragana == false)
        #expect(viewModel.useAdvancedHiragana == false)
        #expect(viewModel.showHintButtons == true)
    }
    
    @Test("Settings are saved to UserDefaults")
    func testSettingsPersistence() {
        let viewModel = SettingsViewModel()
        
        viewModel.useIntermediateHiragana = true
        viewModel.showHintButtons = false
        
        let defaults = UserDefaults.standard
        #expect(defaults.bool(forKey: "useIntermediateHiragana") == true)
        #expect(defaults.bool(forKey: "showHintButtons") == false)
    }
    
    @Test("Enabling standard auto-enables basic")
    func testStandardEnablesBasic() {
        let viewModel = SettingsViewModel()
        
        viewModel.useBasicHiragana = false
        viewModel.useStandardHiragana = true
        
        #expect(viewModel.useBasicHiragana == true)
    }
    
    @Test("Enabling intermediate auto-enables basic and standard")
    func testIntermediateEnablesLowerLevels() {
        let viewModel = SettingsViewModel()
        
        viewModel.useBasicHiragana = false
        viewModel.useStandardHiragana = false
        viewModel.useIntermediateHiragana = true
        
        #expect(viewModel.useBasicHiragana == true)
        #expect(viewModel.useStandardHiragana == true)
    }
    
    @Test("Enabling advanced auto-enables all levels")
    func testAdvancedEnablesAllLevels() {
        let viewModel = SettingsViewModel()
        
        viewModel.useBasicHiragana = false
        viewModel.useStandardHiragana = false
        viewModel.useIntermediateHiragana = false
        viewModel.useAdvancedHiragana = true
        
        #expect(viewModel.useBasicHiragana == true)
        #expect(viewModel.useStandardHiragana == true)
        #expect(viewModel.useIntermediateHiragana == true)
    }
    
    @Test("Disabling basic disables all levels")
    func testDisablingBasicDisablesAll() {
        let viewModel = SettingsViewModel()
        
        viewModel.useAdvancedHiragana = true  // This sets all to true
        viewModel.useBasicHiragana = false
        
        #expect(viewModel.useBasicHiragana == false)
        #expect(viewModel.useStandardHiragana == false)
        #expect(viewModel.useIntermediateHiragana == false)
        #expect(viewModel.useAdvancedHiragana == false)
    }
    
    @Test("Disabling standard disables higher levels")
    func testDisablingStandardDisablesHigher() {
        let viewModel = SettingsViewModel()
        
        viewModel.useAdvancedHiragana = true  // This sets all to true
        viewModel.useStandardHiragana = false
        
        #expect(viewModel.useBasicHiragana == true)  // Basic remains
        #expect(viewModel.useStandardHiragana == false)
        #expect(viewModel.useIntermediateHiragana == false)
        #expect(viewModel.useAdvancedHiragana == false)
    }
    
    @Test("Disabling intermediate disables advanced")
    func testDisablingIntermediateDisablesAdvanced() {
        let viewModel = SettingsViewModel()
        
        viewModel.useAdvancedHiragana = true  // This sets all to true
        viewModel.useIntermediateHiragana = false
        
        #expect(viewModel.useBasicHiragana == true)
        #expect(viewModel.useStandardHiragana == true)
        #expect(viewModel.useIntermediateHiragana == false)
        #expect(viewModel.useAdvancedHiragana == false)
    }
    
    @Test("Reset to defaults restores initial values")
    func testResetToDefaults() {
        let viewModel = SettingsViewModel()
        
        // Change all settings
        viewModel.useAdvancedHiragana = true
        viewModel.showHintButtons = false
        
        // Reset
        viewModel.resetToDefaults()
        
        #expect(viewModel.useBasicHiragana == true)
        #expect(viewModel.useStandardHiragana == true)
        #expect(viewModel.useIntermediateHiragana == false)
        #expect(viewModel.useAdvancedHiragana == false)
        #expect(viewModel.showHintButtons == true)
    }
    
    @Test("Settings change posts notification")
    func testSettingsChangeNotification() async {
        let viewModel = SettingsViewModel()
        var notificationReceived = false
        
        let cancellable = NotificationCenter.default.publisher(for: .settingsChanged)
            .sink { _ in
                notificationReceived = true
            }
        
        viewModel.useIntermediateHiragana = true
        
        // Allow time for notification
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        #expect(notificationReceived == true)
        
        cancellable.cancel()
    }
}