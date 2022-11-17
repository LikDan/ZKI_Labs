//
//  ContentView.swift
//  Encrypt
//
//  Created by Lik Dan on 11/10/22.
//

import SwiftUI

struct Lab4Task2: View {

    @State private var word: String = "ATTACKATDAWN"
    @State private var encrypted: String = ""
    @State private var key: String = "LEMON"
    @State private var key2: String = "LEMON2"
    @State private var res: String = "-"

    var body: some View {
        VStack {
            TextField("Word", text: $word)
            TextField("Encryption", text: $encrypted)
            TextField("Key", text: $key)
            TextField("Key2", text: $key2)
            Button("Encrypt", action: encrypt)
            Button("Decrypt", action: decrypt)
            Text(res)
        }
                .buttonStyle(.bordered)
                .padding()
    }


    func generateTable(k: String) -> [[String.Element]] {
        var random = RandomNumberGeneratorWithSeed(seed: k.hashValue)

        let symbols = String((65...90).map({ Character(UnicodeScalar($0)) })) + "1234567890"
        return Array(symbols.shuffled(using: &random)).chunked(into: 6);
    }

    func getSymbol(from: [[String.Element]], to: [[String.Element]], c: String.Element) -> String.Element {
        let y = from.firstIndex(where: { $0.contains(where: { $0 == c }) })!
        let x = from[y].firstIndex(where: { $0 == c })!;

        return to[y][x]
    }

    func encrypt() -> Void {
        var table1 = generateTable(k: key)
        var table2 = generateTable(k: key2)

        var encr = ""
        for pair in Array(word).chunked(into: 2) {
            encr += String(getSymbol(from: table1, to: table2, c: pair[0]))
            encr += String(getSymbol(from: table2, to: table1, c: pair[1]))
            encr += " "
        }

        encrypted = encr
        res = encr
    }


    func decrypt() -> Void {
        var table1 = generateTable(k: key)
        var table2 = generateTable(k: key2)

        var decrypted = ""
        for pair in Array(encrypted).chunked(into: 3) {
            decrypted += String(getSymbol(from: table2, to: table1, c: pair[0]))
            decrypted += String(getSymbol(from: table1, to: table2, c: pair[1]))
        }

        res = decrypted
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

struct RandomNumberGeneratorWithSeed: RandomNumberGenerator {
    init(seed: Int) {
        srand48(seed)
    }

    func next() -> UInt64 {
        return UInt64(drand48() * Double(UInt64.max))
    }
}
