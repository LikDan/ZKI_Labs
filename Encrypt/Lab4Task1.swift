//
//  ContentView.swift
//  Encrypt
//
//  Created by Lik Dan on 11/10/22.
//

import SwiftUI

struct Lab4Task1: View {

    @State private var word: String = "ATTACKATDAWN"
    @State private var encrypted: String = "LXFOPVEFRNHR"
    @State private var key: String = "LEMON"
    @State private var res: String = "-"

    var body: some View {
        VStack {
            TextField("Word", text: $word)
            TextField("Encryption", text: $encrypted)
            TextField("Key", text: $key)
            Button("Encrypt", action: encrypt)
            Button("Decrypt", action: decrypt)
            Text(res)
        }
                .buttonStyle(.bordered)
                .padding()
    }

    func getEncryptionSymbol(i: Character, k: Character) -> String {
        var index = UnicodeScalar(String(i))!.value - 65 + UnicodeScalar(String(k))!.value - 65
        index %= 26
        return String(UnicodeScalar(index + 65)!)
    }

    func encrypt() -> Void {
        var cycleKey = ""
        for _ in 0...(word.count / key.count) {
            cycleKey += key;
        }

        cycleKey = String(cycleKey.prefix(word.count))

        var encryption = ""
        for i in 0..<cycleKey.count {
            encryption += getEncryptionSymbol(i: Array(word)[i], k: Array(cycleKey)[i])
        }

        res = encryption
    }


    func getDecryptionSymbol(i: Character, k: Character) -> String {
        var index = UnicodeScalar(String(i))!.value - 65 + 26 - (UnicodeScalar(String(k))!.value - 65)
        index %= 26
        return String(UnicodeScalar(index + 65)!)
    }

    func decrypt() -> Void {
        var cycleKey = ""
        for _ in 0...(encrypted.count / key.count) {
            cycleKey += key;
        }

        cycleKey = String(cycleKey.prefix(encrypted.count))

        var encryption = ""
        for i in 0..<cycleKey.count {
            encryption += getDecryptionSymbol(i: Array(encrypted)[i], k: Array(cycleKey)[i])
        }

        res = encryption
    }
}
