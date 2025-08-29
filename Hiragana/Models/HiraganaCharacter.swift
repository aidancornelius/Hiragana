//
//  HiraganaCharacter.swift
//  Hiragana
//
//  Created by Aidan Cornelius-Bell on 29/8/2025.
//

import Foundation

struct HiraganaCharacter: Identifiable, Equatable {
    let id = UUID()
    let character: String
    let romaji: String
    let level: Level
    
    enum Level: String, CaseIterable {
        case basic = "Basic"
        case standard = "Standard"
        case intermediate = "Intermediate"
        case advanced = "Advanced"
    }
}

struct HiraganaData {
    static let all: [HiraganaCharacter] = [
        // Basic (vowels)
        HiraganaCharacter(character: "あ", romaji: "a", level: .basic),
        HiraganaCharacter(character: "い", romaji: "i", level: .basic),
        HiraganaCharacter(character: "う", romaji: "u", level: .basic),
        HiraganaCharacter(character: "え", romaji: "e", level: .basic),
        HiraganaCharacter(character: "お", romaji: "o", level: .basic),
        
        // Standard (K, S, T, N rows)
        HiraganaCharacter(character: "か", romaji: "ka", level: .standard),
        HiraganaCharacter(character: "き", romaji: "ki", level: .standard),
        HiraganaCharacter(character: "く", romaji: "ku", level: .standard),
        HiraganaCharacter(character: "け", romaji: "ke", level: .standard),
        HiraganaCharacter(character: "こ", romaji: "ko", level: .standard),
        HiraganaCharacter(character: "さ", romaji: "sa", level: .standard),
        HiraganaCharacter(character: "し", romaji: "shi", level: .standard),
        HiraganaCharacter(character: "す", romaji: "su", level: .standard),
        HiraganaCharacter(character: "せ", romaji: "se", level: .standard),
        HiraganaCharacter(character: "そ", romaji: "so", level: .standard),
        HiraganaCharacter(character: "た", romaji: "ta", level: .standard),
        HiraganaCharacter(character: "ち", romaji: "chi", level: .standard),
        HiraganaCharacter(character: "つ", romaji: "tsu", level: .standard),
        HiraganaCharacter(character: "て", romaji: "te", level: .standard),
        HiraganaCharacter(character: "と", romaji: "to", level: .standard),
        HiraganaCharacter(character: "な", romaji: "na", level: .standard),
        HiraganaCharacter(character: "に", romaji: "ni", level: .standard),
        HiraganaCharacter(character: "ぬ", romaji: "nu", level: .standard),
        HiraganaCharacter(character: "ね", romaji: "ne", level: .standard),
        HiraganaCharacter(character: "の", romaji: "no", level: .standard),
        
        // Intermediate (H, M, Y, R, W rows + N, WO)
        HiraganaCharacter(character: "は", romaji: "ha", level: .intermediate),
        HiraganaCharacter(character: "ひ", romaji: "hi", level: .intermediate),
        HiraganaCharacter(character: "ふ", romaji: "fu", level: .intermediate),
        HiraganaCharacter(character: "へ", romaji: "he", level: .intermediate),
        HiraganaCharacter(character: "ほ", romaji: "ho", level: .intermediate),
        HiraganaCharacter(character: "ま", romaji: "ma", level: .intermediate),
        HiraganaCharacter(character: "み", romaji: "mi", level: .intermediate),
        HiraganaCharacter(character: "む", romaji: "mu", level: .intermediate),
        HiraganaCharacter(character: "め", romaji: "me", level: .intermediate),
        HiraganaCharacter(character: "も", romaji: "mo", level: .intermediate),
        HiraganaCharacter(character: "や", romaji: "ya", level: .intermediate),
        HiraganaCharacter(character: "ゆ", romaji: "yu", level: .intermediate),
        HiraganaCharacter(character: "よ", romaji: "yo", level: .intermediate),
        HiraganaCharacter(character: "ら", romaji: "ra", level: .intermediate),
        HiraganaCharacter(character: "り", romaji: "ri", level: .intermediate),
        HiraganaCharacter(character: "る", romaji: "ru", level: .intermediate),
        HiraganaCharacter(character: "れ", romaji: "re", level: .intermediate),
        HiraganaCharacter(character: "ろ", romaji: "ro", level: .intermediate),
        HiraganaCharacter(character: "わ", romaji: "wa", level: .intermediate),
        HiraganaCharacter(character: "ん", romaji: "n", level: .intermediate),
        HiraganaCharacter(character: "を", romaji: "wo", level: .intermediate),
        
        // Advanced (Dakuten and Handakuten)
        HiraganaCharacter(character: "が", romaji: "ga", level: .advanced),
        HiraganaCharacter(character: "ぎ", romaji: "gi", level: .advanced),
        HiraganaCharacter(character: "ぐ", romaji: "gu", level: .advanced),
        HiraganaCharacter(character: "げ", romaji: "ge", level: .advanced),
        HiraganaCharacter(character: "ご", romaji: "go", level: .advanced),
        HiraganaCharacter(character: "ざ", romaji: "za", level: .advanced),
        HiraganaCharacter(character: "じ", romaji: "ji", level: .advanced),
        HiraganaCharacter(character: "ず", romaji: "zu", level: .advanced),
        HiraganaCharacter(character: "ぜ", romaji: "ze", level: .advanced),
        HiraganaCharacter(character: "ぞ", romaji: "zo", level: .advanced),
        HiraganaCharacter(character: "だ", romaji: "da", level: .advanced),
        HiraganaCharacter(character: "ぢ", romaji: "ji", level: .advanced),
        HiraganaCharacter(character: "づ", romaji: "zu", level: .advanced),
        HiraganaCharacter(character: "で", romaji: "de", level: .advanced),
        HiraganaCharacter(character: "ど", romaji: "do", level: .advanced),
        HiraganaCharacter(character: "ば", romaji: "ba", level: .advanced),
        HiraganaCharacter(character: "び", romaji: "bi", level: .advanced),
        HiraganaCharacter(character: "ぶ", romaji: "bu", level: .advanced),
        HiraganaCharacter(character: "べ", romaji: "be", level: .advanced),
        HiraganaCharacter(character: "ぼ", romaji: "bo", level: .advanced),
        HiraganaCharacter(character: "ぱ", romaji: "pa", level: .advanced),
        HiraganaCharacter(character: "ぴ", romaji: "pi", level: .advanced),
        HiraganaCharacter(character: "ぷ", romaji: "pu", level: .advanced),
        HiraganaCharacter(character: "ぺ", romaji: "pe", level: .advanced),
        HiraganaCharacter(character: "ぽ", romaji: "po", level: .advanced)
    ]
    
    static func characters(for levels: Set<HiraganaCharacter.Level>) -> [HiraganaCharacter] {
        all.filter { levels.contains($0.level) }
    }
}
