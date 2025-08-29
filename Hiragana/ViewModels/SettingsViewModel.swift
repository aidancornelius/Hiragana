//
//  SettingsViewModel.swift
//  Hiragana
//
//  Created by Aidan Cornelius-Bell on 29/8/2025.
//

import SwiftUI
import Combine

class SettingsViewModel: ObservableObject {
    @Published var useBasicHiragana: Bool {
        didSet {
            saveSettings()
            // Basic is always included when any other level is selected
            if !useBasicHiragana {
                useStandardHiragana = false
                useIntermediateHiragana = false
                useAdvancedHiragana = false
            }
        }
    }
    
    @Published var useStandardHiragana: Bool {
        didSet {
            saveSettings()
            // Standard includes basic
            if useStandardHiragana {
                useBasicHiragana = true
            }
            // If standard is turned off, higher levels are also turned off
            if !useStandardHiragana {
                useIntermediateHiragana = false
                useAdvancedHiragana = false
            }
        }
    }
    
    @Published var useIntermediateHiragana: Bool {
        didSet {
            saveSettings()
            // Intermediate includes standard and basic
            if useIntermediateHiragana {
                useBasicHiragana = true
                useStandardHiragana = true
            }
            // If intermediate is turned off, advanced is also turned off
            if !useIntermediateHiragana {
                useAdvancedHiragana = false
            }
        }
    }
    
    @Published var useAdvancedHiragana: Bool {
        didSet {
            saveSettings()
            // Advanced includes all lower levels
            if useAdvancedHiragana {
                useBasicHiragana = true
                useStandardHiragana = true
                useIntermediateHiragana = true
            }
        }
    }
    
    @Published var showHintButtons: Bool {
        didSet {
            saveSettings()
        }
    }
    
    private let defaults = UserDefaults.standard
    
    init() {
        // Load saved settings or use defaults
        self.useBasicHiragana = defaults.object(forKey: "useBasicHiragana") as? Bool ?? true
        self.useStandardHiragana = defaults.object(forKey: "useStandardHiragana") as? Bool ?? true
        self.useIntermediateHiragana = defaults.object(forKey: "useIntermediateHiragana") as? Bool ?? false
        self.useAdvancedHiragana = defaults.object(forKey: "useAdvancedHiragana") as? Bool ?? false
        self.showHintButtons = defaults.object(forKey: "showHintButtons") as? Bool ?? true
    }
    
    private func saveSettings() {
        defaults.set(useBasicHiragana, forKey: "useBasicHiragana")
        defaults.set(useStandardHiragana, forKey: "useStandardHiragana")
        defaults.set(useIntermediateHiragana, forKey: "useIntermediateHiragana")
        defaults.set(useAdvancedHiragana, forKey: "useAdvancedHiragana")
        defaults.set(showHintButtons, forKey: "showHintButtons")
        
        // Notify game view model of changes
        NotificationCenter.default.post(name: .settingsChanged, object: nil)
    }
    
    func resetToDefaults() {
        useBasicHiragana = true
        useStandardHiragana = true
        useIntermediateHiragana = false
        useAdvancedHiragana = false
        showHintButtons = true
    }
}
