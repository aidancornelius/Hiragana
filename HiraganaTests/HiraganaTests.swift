//
//  HiraganaTests.swift
//  HiraganaTests
//
//  Created by Aidan Cornelius-Bell on 29/8/2025.
//

import Testing
import Foundation
@testable import Hiragana

struct HiraganaCharacterTests {
    
    @Test("Hiragana character has unique ID")
    func testCharacterHasUniqueID() {
        let char1 = HiraganaCharacter(character: "あ", romaji: "a", level: .basic)
        let char2 = HiraganaCharacter(character: "あ", romaji: "a", level: .basic)
        
        #expect(char1.id != char2.id)
    }
    
    @Test("Hiragana characters are equal when all properties match")
    func testCharacterEquality() {
        let char1 = HiraganaCharacter(character: "あ", romaji: "a", level: .basic)
        let char2 = HiraganaCharacter(character: "い", romaji: "i", level: .basic)
        let char3 = HiraganaCharacter(character: "あ", romaji: "a", level: .standard)
        
        #expect(char1 != char2)
        #expect(char1 != char3)
    }
    
    @Test("All hiragana levels are represented")
    func testAllLevelsExist() {
        let levels = HiraganaCharacter.Level.allCases
        
        #expect(levels.count == 4)
        #expect(levels.contains(.basic))
        #expect(levels.contains(.standard))
        #expect(levels.contains(.intermediate))
        #expect(levels.contains(.advanced))
    }
    
    @Test("Level raw values are correct")
    func testLevelRawValues() {
        #expect(HiraganaCharacter.Level.basic.rawValue == "Basic")
        #expect(HiraganaCharacter.Level.standard.rawValue == "Standard")
        #expect(HiraganaCharacter.Level.intermediate.rawValue == "Intermediate")
        #expect(HiraganaCharacter.Level.advanced.rawValue == "Advanced")
    }
}

struct HiraganaDataTests {
    
    @Test("HiraganaData contains correct number of characters")
    func testCharacterCount() {
        let allCharacters = HiraganaData.all
        
        #expect(allCharacters.count == 104)
        
        let basicCount = allCharacters.filter { $0.level == .basic }.count
        let standardCount = allCharacters.filter { $0.level == .standard }.count
        let intermediateCount = allCharacters.filter { $0.level == .intermediate }.count
        let advancedCount = allCharacters.filter { $0.level == .advanced }.count
        
        #expect(basicCount == 5)  // あ, い, う, え, お
        #expect(standardCount == 20)  // K, S, T, N rows
        #expect(intermediateCount == 21)  // H, M, Y, R, W rows + ん, を
        #expect(advancedCount == 25)  // Dakuten and Handakuten
    }
    
    @Test("Basic hiragana contains correct vowels")
    func testBasicHiragana() {
        let basicChars = HiraganaData.characters(for: [.basic])
        
        #expect(basicChars.count == 5)
        
        let expectedRomaji = ["a", "i", "u", "e", "o"]
        let actualRomaji = basicChars.map { $0.romaji }
        
        for romaji in expectedRomaji {
            #expect(actualRomaji.contains(romaji))
        }
    }
    
    @Test("Characters filter by single level")
    func testFilterBySingleLevel() {
        let standardOnly = HiraganaData.characters(for: [.standard])
        
        #expect(standardOnly.count == 20)
        #expect(standardOnly.allSatisfy { $0.level == .standard })
    }
    
    @Test("Characters filter by multiple levels")
    func testFilterByMultipleLevels() {
        let basicAndStandard = HiraganaData.characters(for: [.basic, .standard])
        
        #expect(basicAndStandard.count == 25)
        #expect(basicAndStandard.allSatisfy { $0.level == .basic || $0.level == .standard })
    }
    
    @Test("Empty level set returns empty array")
    func testEmptyLevelFilter() {
        let noCharacters = HiraganaData.characters(for: [])
        
        #expect(noCharacters.isEmpty)
    }
    
    @Test("All levels returns all characters")
    func testAllLevelsFilter() {
        let allLevels: Set<HiraganaCharacter.Level> = [.basic, .standard, .intermediate, .advanced]
        let filteredCharacters = HiraganaData.characters(for: allLevels)
        
        #expect(filteredCharacters.count == HiraganaData.all.count)
    }
    
    @Test("No duplicate characters exist")
    func testNoDuplicates() {
        let allCharacters = HiraganaData.all
        let uniqueCharacters = Set(allCharacters.map { $0.character })
        
        #expect(uniqueCharacters.count == allCharacters.count)
    }
    
    @Test("Romaji romanisation is consistent")
    func testRomajiConsistency() {
        let shiChar = HiraganaData.all.first { $0.character == "し" }
        let chiChar = HiraganaData.all.first { $0.character == "ち" }
        let tsuChar = HiraganaData.all.first { $0.character == "つ" }
        let fuChar = HiraganaData.all.first { $0.character == "ふ" }
        
        #expect(shiChar?.romaji == "shi")
        #expect(chiChar?.romaji == "chi")
        #expect(tsuChar?.romaji == "tsu")
        #expect(fuChar?.romaji == "fu")
    }
    
    @Test("Advanced characters include all dakuten and handakuten")
    func testAdvancedCharacters() {
        let advancedChars = HiraganaData.characters(for: [.advanced])
        
        let dakutenGa = advancedChars.contains { $0.character == "が" && $0.romaji == "ga" }
        let dakutenJi = advancedChars.contains { $0.character == "じ" && $0.romaji == "ji" }
        let handakutenPa = advancedChars.contains { $0.character == "ぱ" && $0.romaji == "pa" }
        
        #expect(dakutenGa)
        #expect(dakutenJi)
        #expect(handakutenPa)
    }
}
