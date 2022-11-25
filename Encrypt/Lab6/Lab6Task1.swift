//
//  Lab6Task1.swift
//  Encrypt
//
//  Created by Lik Dan on 11/17/22.
//
//

import SwiftUI

struct Lab6Task1: View {
    init(back: @escaping () -> ()) {
        self.back = back
    }

    private let back: () -> Void

    @State private var key: String = "KEY"
    @State private var key2: String = "KEY"
    @State private var num: String = "NUMBER"

    @State private var y: Int = 0
    @State private var g: Int = 0
    @State private var p: Int = 0
    @State private var x: Int = 0

    @State private var a: Int = 0
    @State private var b: Int = 0

    var body: some View {
        HStack {
            Button("Back", action: back)
            Spacer()
        }
        Text(key)
        Text(key2)
        TextField("Number", text: $num)
        Button("Generate") {
            (p, g, y, x) = generateKeyPair()
            key = "\(p) \(g) \(y)"
            key2 = "\(x)"
        }
        Button("Encrypt") {
            (a, b) = encrypt(y: y, g: g, p: p, x: x, num: Int(num) ?? 1)
            key = "\(a) \(b)"
        }

        Button("Decrypt") {
            let m = decrypt(b: b, a: a, x: x, p: p)
            key = "\(m)"
        }
    }

    func generateKeyPair() -> (Int, Int, Int, Int) {
        let pairs = [(5, 2), (7, 3), (11, 2), (13, 2)]

        let (p, g) = pairs.randomElement() ?? pairs[0]
        let x = (2..<p - 1).randomElement() ?? 0
        let y = NSDecimalNumber(decimal: pow(Decimal(g), x)).intValue % p

        return (p, g, y, x);
    }

    func encrypt(y: Int, g: Int, p: Int, x: Int, num: Int) -> (Int, Int) {
        let k = (1..<p).randomElement() ?? 0
        let a = NSDecimalNumber(decimal: pow(Decimal(g), k)).intValue % p
        let b = (NSDecimalNumber(decimal: pow(Decimal(y), k)).intValue * num) % p
        return (a, b)
    }

    func decrypt(b: Int, a: Int, x: Int, p: Int) -> Int {
        Int(Float(b) * pow(Float(a), Float(p - 1 - x))) % p
    }

    func generatePrimeNumberSequence(rangeEndNumber: Int) -> [Int] {
        let firstPrime = 3
        guard rangeEndNumber >= firstPrime else {
            fatalError("End of range has to be greater than or equal to \(firstPrime)!")
        }
        var numbers = Array(firstPrime...rangeEndNumber)
        var currentPrimeIndex = 0

        while currentPrimeIndex < numbers.count {
            let currentPrime = numbers[currentPrimeIndex]

            var numbersAfterPrime = numbers.suffix(from: currentPrimeIndex + 1)
            numbersAfterPrime.removeAll(where: { $0 % currentPrime == 0 })

            numbers = numbers.prefix(currentPrimeIndex + 1) + Array(numbersAfterPrime)
            currentPrimeIndex += 1
        }

        return numbers
    }

    func findMinPrimitiveRoot(n: Int) -> Int {
        var num = 2
        whileLoop: while num < 1000 {
            var numbers = [1]
            for i in 1..<n - 1 {
                let l = NSDecimalNumber(decimal: pow(Decimal(num), i)).intValue % n
                if numbers.contains(l) || l == 0 {
                    num += 1
                    continue whileLoop
                }

                numbers.append(l)
            }

            return num
        }

        return 0
    }

    func getNOD(_ firstNumber: Int, _ secondNumber: Int) -> Int {
        if firstNumber == secondNumber {
            return firstNumber
        }

        if firstNumber == 0 {
            return secondNumber
        }
        if secondNumber == 0 {
            return firstNumber
        }

        var firstNumber = firstNumber
        var secondNumber = secondNumber
        while firstNumber != 0, secondNumber != 0 {
            if firstNumber > secondNumber {
                firstNumber = firstNumber - secondNumber
            } else {
                secondNumber = secondNumber - firstNumber
            }
        }

        return firstNumber + secondNumber
    }
}
