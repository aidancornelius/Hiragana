//
//  GameViewModel.swift
//  Hiragana
//
//  Created by Aidan Cornelius-Bell on 29/8/2025.
//

import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var currentCharacter: HiraganaCharacter?
    @Published var userInput: String = ""
    @Published var isAnswerCorrect: Bool?
    @Published var showHint: Bool = false
    @Published var streak: Int = 0
    @Published var totalAttempts: Int = 0
    @Published var correctAnswers: Int = 0
    
    private var availableCharacters: [HiraganaCharacter] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscriptions()
    }
    
    private func setupSubscriptions() {
        NotificationCenter.default.publisher(for: .settingsChanged)
            .sink { [weak self] _ in
                self?.updateAvailableCharacters()
                self?.selectNewCharacter()
            }
            .store(in: &cancellables)
    }
    
    func startGame(with settings: SettingsViewModel) {
        updateAvailableCharacters(from: settings)
        selectNewCharacter()
    }
    
    private func updateAvailableCharacters(from settings: SettingsViewModel? = nil) {
        let settings = settings ?? SettingsViewModel()
        var activeLevels = Set<HiraganaCharacter.Level>()
        
        // Map settings to levels (progressive difficulty)
        // Always include basic if any level is selected
        if settings.useBasicHiragana || settings.useStandardHiragana || 
           settings.useIntermediateHiragana || settings.useAdvancedHiragana {
            activeLevels.insert(.basic)
        }
        
        if settings.useStandardHiragana || settings.useIntermediateHiragana || 
           settings.useAdvancedHiragana {
            activeLevels.insert(.standard)
        }
        
        if settings.useIntermediateHiragana || settings.useAdvancedHiragana {
            activeLevels.insert(.intermediate)
        }
        
        if settings.useAdvancedHiragana {
            activeLevels.insert(.advanced)
        }
        
        // Default to basic + standard if nothing selected
        if activeLevels.isEmpty {
            activeLevels.insert(.basic)
            activeLevels.insert(.standard)
        }
        
        availableCharacters = HiraganaData.characters(for: activeLevels)
    }
    
    func selectNewCharacter() {
        guard !availableCharacters.isEmpty else {
            updateAvailableCharacters()
            return
        }
        
        let newCharacter = availableCharacters.randomElement()
        
        // Avoid repeating the same character
        if newCharacter == currentCharacter && availableCharacters.count > 1 {
            selectNewCharacter()
        } else {
            currentCharacter = newCharacter
            userInput = ""
            isAnswerCorrect = nil
            showHint = false
        }
    }
    
    func checkAnswer() {
        guard let current = currentCharacter else { return }
        
        totalAttempts += 1
        let isCorrect = userInput.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == current.romaji.lowercased()
        
        if isCorrect {
            correctAnswers += 1
            streak += 1
            isAnswerCorrect = true
            
            // Auto-advance after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.selectNewCharacter()
            }
        } else {
            streak = 0
            isAnswerCorrect = false
            
            // Clear input for retry
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                self?.userInput = ""
                self?.isAnswerCorrect = nil
            }
        }
    }
    
    func skipCharacter() {
        streak = 0
        selectNewCharacter()
    }
    
    func toggleHint() {
        showHint.toggle()
    }
    
    var accuracy: Double {
        guard totalAttempts > 0 else { return 0 }
        return Double(correctAnswers) / Double(totalAttempts) * 100
    }
}

extension Notification.Name {
    static let settingsChanged = Notification.Name("settingsChanged")
}
