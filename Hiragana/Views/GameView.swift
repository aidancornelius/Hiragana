//
//  GameView.swift
//  Hiragana
//
//  Created by Aidan Cornelius-Bell on 29/8/2025.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @FocusState private var isInputFocused: Bool
    @State private var showingStatistics = false
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @Environment(\.colorSchemeContrast) var colorContrast
    
    private var characterFontSize: CGFloat {
        switch dynamicTypeSize {
        case .xSmall, .small: return 70
        case .medium, .large: return 90
        case .xLarge: return 100
        case .xxLarge: return 110
        case .xxxLarge: return 120
        case .accessibility1: return 130
        case .accessibility2: return 140
        case .accessibility3: return 150
        case .accessibility4: return 160
        case .accessibility5: return 170
        @unknown default: return 90
        }
    }
    
    var body: some View {
        VStack(spacing: dynamicTypeSize.isAccessibilitySize ? 16 : 12) {
            // Statistics bar
            HStack {
                Label("\(gameViewModel.streak)", systemImage: "flame.fill")
                    .foregroundColor(gameViewModel.streak > 5 ? .orange : (colorContrast == .increased ? .primary : .secondary))
                    .accessibilityLabel("Streak: \(gameViewModel.streak)")
                
                Spacer()
                
                if gameViewModel.totalAttempts > 0 {
                    Label(String(format: "%.0f%%", gameViewModel.accuracy), systemImage: "chart.line.uptrend.xyaxis")
                        .foregroundColor(colorContrast == .increased ? .primary : .secondary)
                        .accessibilityLabel("Accuracy: \(Int(gameViewModel.accuracy)) percent")
                }
            }
            .padding(.horizontal)
            .font(.headline)
            
            Spacer()
            
            // Main hiragana display
            if let character = gameViewModel.currentCharacter {
                VStack(spacing: 16) {
                    Text(character.character)
                        .font(.system(size: characterFontSize, weight: .medium, design: .rounded))
                        .foregroundColor(.primary)
                        .scaleEffect(gameViewModel.isAnswerCorrect == true ? (reduceMotion ? 1.0 : 1.1) : 1.0)
                        .animation(reduceMotion ? nil : .spring(response: 0.3), value: gameViewModel.isAnswerCorrect)
                        .accessibilityLabel("Hiragana character")
                        .accessibilityHint("Type the romaji for this character")
                        .accessibilityAddTraits(.isHeader)
                    
                    // Hint display
                    if gameViewModel.showHint {
                        Text(character.romaji)
                            .font(.title2)
                            .foregroundColor(colorContrast == .increased ? .primary : .secondary)
                            .transition(reduceMotion ? .opacity : .scale.combined(with: .opacity))
                            .accessibilityLabel("Answer: \(character.romaji)")
                    }
                }
            } else {
                ProgressView()
                    .accessibilityLabel("Loading hiragana character")
                    .onAppear {
                        gameViewModel.startGame(with: settingsViewModel)
                    }
            }
            
            Spacer()
            
            // Input field
            VStack(spacing: dynamicTypeSize.isAccessibilitySize ? 16 : 12) {
                HStack {
                    TextField("Enter romaji", text: $gameViewModel.userInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .focused($isInputFocused)
                        .onSubmit {
                            gameViewModel.checkAnswer()
                        }
                        .accessibilityLabel("Romaji input")
                        .accessibilityHint("Enter the romaji for the displayed hiragana character")
                        .overlay(alignment: .trailing) {
                            if let isCorrect = gameViewModel.isAnswerCorrect {
                                Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .foregroundColor(isCorrect ? (colorContrast == .increased ? .green : .green) : (colorContrast == .increased ? .red : .red))
                                    .padding(.trailing, 8)
                                    .transition(reduceMotion ? .opacity : .scale.combined(with: .opacity))
                                    .accessibilityLabel(isCorrect ? "Correct" : "Incorrect")
                            }
                        }
                    
                    Button("Check") {
                        gameViewModel.checkAnswer()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(gameViewModel.userInput.isEmpty)
                    .accessibilityHint("Submit your answer")
                }
                
                // Action buttons
                if settingsViewModel.showHintButtons {
                    HStack(spacing: 15) {
                        Button(action: {
                            gameViewModel.skipCharacter()
                        }) {
                            Label("Skip", systemImage: "forward.fill")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .accessibilityHint("Skip to the next character")
                        
                        Button(action: {
                            gameViewModel.toggleHint()
                        }) {
                            Label(gameViewModel.showHint ? "Hide" : "Show",
                                  systemImage: gameViewModel.showHint ? "eye.slash.fill" : "eye.fill")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .accessibilityLabel(gameViewModel.showHint ? "Hide answer" : "Show answer")
                        .accessibilityHint(gameViewModel.showHint ? "Hide the romaji answer" : "Show the romaji answer")
                    }
                    .font(dynamicTypeSize.isAccessibilitySize ? .body : .callout)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
        .padding(.vertical, 16)
        .onAppear {
            isInputFocused = true
            if gameViewModel.currentCharacter == nil {
                gameViewModel.startGame(with: settingsViewModel)
            }
        }
        .accessibilityElement(children: .contain)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GameView()
                .environmentObject(GameViewModel())
                .environmentObject(SettingsViewModel())
        }
    }
}