//
//  SettingsView.swift
//  Hiragana
//
//  Created by Aidan Cornelius-Bell on 29/8/2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading, spacing: 20) {
                        LevelToggle(
                            title: "Basic",
                            subtitle: "Vowels (あ, い, う, え, お)",
                            isOn: $settingsViewModel.useBasicHiragana,
                            color: .blue
                        )
                        
                        LevelToggle(
                            title: "Standard",
                            subtitle: "K, S, T, N rows",
                            isOn: $settingsViewModel.useStandardHiragana,
                            color: .green
                        )
                        
                        LevelToggle(
                            title: "Intermediate",
                            subtitle: "H, M, Y, R, W rows + ん, を",
                            isOn: $settingsViewModel.useIntermediateHiragana,
                            color: .orange
                        )
                        
                        LevelToggle(
                            title: "Advanced",
                            subtitle: "Dakuten & handakuten",
                            isOn: $settingsViewModel.useAdvancedHiragana,
                            color: .red
                        )
                    }
                    .padding(.vertical, 5)
                } header: {
                    Text("Difficulty Levels")
                } footer: {
                    Text("Each level includes all previous levels. For example, selecting Intermediate will also include Basic and Standard characters.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Section("Game Options") {
                    Toggle(isOn: $settingsViewModel.showHintButtons) {
                        HStack {
                            Image(systemName: "questionmark.circle.fill")
                                .foregroundColor(.blue)
                            Text("Show answer & skip buttons")
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        settingsViewModel.resetToDefaults()
                    }) {
                        HStack {
                            Image(systemName: "arrow.counterclockwise")
                            Text("Reset to defaults")
                        }
                    }
                    .foregroundColor(.blue)
                }
                
                Section("About") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Made by Aidan Cornelius-Bell on Kaurna Country in Adelaide, Australia. First released over ten years ago.")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                        HStack {
                            Text("If you need support please contact:")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                        
                        Button(action: {
                            if let url = URL(string: "mailto:aidan@cornelius-bell.com") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Text("aidan@cornelius-bell.com")
                                .font(.footnote)
                                .foregroundColor(.accentColor)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct LevelToggle: View {
    let title: String
    let subtitle: String
    @Binding var isOn: Bool
    let color: Color
    
    var body: some View {
        Toggle(isOn: $isOn) {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Circle()
                        .fill(color)
                        .frame(width: 10, height: 10)
                    Text(title)
                        .font(.headline)
                }
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .toggleStyle(SwitchToggleStyle(tint: color))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(SettingsViewModel())
    }
}
