//
//  Lab7Task1.swift
//  Encrypt
//
//  Created by Lik Dan on 11/18/22.
//
//

import SwiftUI
import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

struct Lab7Task1: View {
    init(back: @escaping () -> ()) {
        self.back = back
    }

    private let back: () -> Void

    @State private var message1: String = "Message"
    @State private var message2: String = "Message"

    @State private var hash1: String = ""
    @State private var hash2: String = ""


    var body: some View {
        VStack {
            HStack {
                Button("Back", action: back)
                Spacer()
            }

            HStack {
                VStack {
                    TextField("Message", text: $message1)
                    TextField("Hash", text: $hash1)
                }

                VStack {
                    TextField("Message", text: $message2)
                    TextField("Received hash", text: $hash1)
                    TextField("Hash", text: $hash2)
                    Button("Check") {
                        hash2 = message2.md5Value
                    }
                }
            }

            Button("Send") {
                hash1 = message1.md5Value

                message2 = message1
            }
        }
    }
}

extension String {
    var md5Value: String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)

        if let d = self.data(using: .utf8) {
            _ = d.withUnsafeBytes { body -> String in
                CC_MD5(body.baseAddress, CC_LONG(d.count), &digest)

                return ""
            }
        }

        return (0 ..< length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
}

