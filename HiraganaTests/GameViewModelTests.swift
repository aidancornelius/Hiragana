//
//  GameViewModelTests.swift
//  HiraganaTests
//
//  Created by Aidan Cornelius-Bell on 29/8/2025.
//

import Testing
import SwiftUI
import Combine
@testable import Hiragana

@MainActor
struct GameViewModelTests {
    
    @Test("GameViewModel initialises with default values")
    func testInitialisation() {
        let viewModel = GameViewModel()
        
        #expect(viewModel.currentCharacter == nil)
        #expect(viewModel.userInput.isEmpty)
        #expect(viewModel.isAnswerCorrect == nil)
        #expect(viewModel.showHint == false)
        #expect(viewModel.streak == 0)
        #expect(viewModel.totalAttempts == 0)
        #expect(viewModel.correctAnswers == 0)
        #expect(viewModel.accuracy == 0)
    }
    
    @Test("Starting game selects a character")
    func testStartGame() {
        let gameViewModel = GameViewModel()
        let settingsViewModel = SettingsViewModel()
        
        gameViewModel.startGame(with: settingsViewModel)
        
        #expect(gameViewModel.currentCharacter != nil)
    }
    
    @Test("Correct answer increases streak and stats")
    func testCorrectAnswer() {
        let gameViewModel = GameViewModel()
        let settingsViewModel = SettingsViewModel()
        
        gameViewModel.startGame(with: settingsViewModel)
        
        guard let character = gameViewModel.currentCharacter else {
            Issue.record("No character selected")
            return
        }
        
        gameViewModel.userInput = character.romaji
        gameViewModel.checkAnswer()
        
        #expect(gameViewModel.isAnswerCorrect == true)
        #expect(gameViewModel.streak == 1)
        #expect(gameViewModel.correctAnswers == 1)
        #expect(gameViewModel.totalAttempts == 1)
        #expect(gameViewModel.accuracy == 100.0)
    }
    
    @Test("Incorrect answer resets streak")
    func testIncorrectAnswer() {
        let gameViewModel = GameViewModel()
        let settingsViewModel = SettingsViewModel()
        
        gameViewModel.startGame(with: settingsViewModel)
        
        // Build up a streak first
        if let character = gameViewModel.currentCharacter {
            gameViewModel.userInput = character.romaji
            gameViewModel.checkAnswer()
        }
        
        // Wait for auto-advance
        Thread.sleep(forTimeInterval: 1.1)
        
        gameViewModel.userInput = "wrong"
        gameViewModel.checkAnswer()
        
        #expect(gameViewModel.isAnswerCorrect == false)
        #expect(gameViewModel.streak == 0)
        #expect(gameViewModel.totalAttempts == 2)
        #expect(gameViewModel.correctAnswers == 1)
        #expect(gameViewModel.accuracy == 50.0)
    }
    
    @Test("Skip character resets streak")
    func testSkipCharacter() {
        let gameViewModel = GameViewModel()
        let settingsViewModel = SettingsViewModel()
        
        gameViewModel.startGame(with: settingsViewModel)
        
        // Build up a streak
        if let character = gameViewModel.currentCharacter {
            gameViewModel.userInput = character.romaji
            gameViewModel.checkAnswer()
        }
        
        Thread.sleep(forTimeInterval: 1.1)
        
        let previousCharacter = gameViewModel.currentCharacter
        gameViewModel.skipCharacter()
        
        #expect(gameViewModel.streak == 0)
        #expect(gameViewModel.currentCharacter != previousCharacter)
        #expect(gameViewModel.userInput.isEmpty)
    }
    
    @Test("Toggle hint shows and hides hint")
    func testToggleHint() {
        let gameViewModel = GameViewModel()
        
        #expect(gameViewModel.showHint == false)
        
        gameViewModel.toggleHint()
        #expect(gameViewModel.showHint == true)
        
        gameViewModel.toggleHint()
        #expect(gameViewModel.showHint == false)
    }
    
    @Test("Answer checking is case insensitive")
    func testCaseInsensitiveAnswerChecking() {
        let gameViewModel = GameViewModel()
        let settingsViewModel = SettingsViewModel()
        
        gameViewModel.startGame(with: settingsViewModel)
        
        guard let character = gameViewModel.currentCharacter else {
            Issue.record("No character selected")
            return
        }
        
        gameViewModel.userInput = character.romaji.uppercased()
        gameViewModel.checkAnswer()
        
        #expect(gameViewModel.isAnswerCorrect == true)
    }
    
    @Test("Answer checking trims whitespace")
    func testWhitespaceTrimming() {
        let gameViewModel = GameViewModel()
        let settingsViewModel = SettingsViewModel()
        
        gameViewModel.startGame(with: settingsViewModel)
        
        guard let character = gameViewModel.currentCharacter else {
            Issue.record("No character selected")
            return
        }
        
        gameViewModel.userInput = "  \(character.romaji)  \n"
        gameViewModel.checkAnswer()
        
        #expect(gameViewModel.isAnswerCorrect == true)
    }
    
    @Test("Select new character avoids repeats when possible")
    func testAvoidRepeatingCharacters() {
        let gameViewModel = GameViewModel()
        let settingsViewModel = SettingsViewModel()
        settingsViewModel.useBasicHiragana = true
        settingsViewModel.useStandardHiragana = false
        
        gameViewModel.startGame(with: settingsViewModel)
        
        var previousCharacters: Set<String> = []
        
        // Basic level has 5 characters, so we should see variety
        for _ in 0..<10 {
            if let current = gameViewModel.currentCharacter {
                previousCharacters.insert(current.character)
            }
            gameViewModel.selectNewCharacter()
        }
        
        // Should have selected multiple different characters
        #expect(previousCharacters.count > 1)
    }
    
    @Test("Settings changes update available characters")
    func testSettingsChangeUpdatesCharacters() async {
        let gameViewModel = GameViewModel()
        let settingsViewModel = SettingsViewModel()
        
        // Start with just basic
        settingsViewModel.useBasicHiragana = true
        settingsViewModel.useStandardHiragana = false
        settingsViewModel.useIntermediateHiragana = false
        settingsViewModel.useAdvancedHiragana = false
        
        gameViewModel.startGame(with: settingsViewModel)
        
        // Collect some characters from basic level
        var basicCharacters: Set<String> = []
        for _ in 0..<20 {
            if let current = gameViewModel.currentCharacter {
                basicCharacters.insert(current.character)
            }
            gameViewModel.selectNewCharacter()
        }
        
        // Now enable advanced (which includes all levels)
        settingsViewModel.useAdvancedHiragana = true
        
        // Post the notification that settings changed
        NotificationCenter.default.post(name: .settingsChanged, object: nil)
        
        // Allow time for notification to process
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        // Collect characters again
        var advancedCharacters: Set<String> = []
        for _ in 0..<50 {
            if let current = gameViewModel.currentCharacter {
                advancedCharacters.insert(current.character)
            }
            gameViewModel.selectNewCharacter()
        }
        
        // Should have more variety with advanced characters
        #expect(advancedCharacters.count > basicCharacters.count)
    }
}