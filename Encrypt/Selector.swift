//
//  ContentView.swift
//  Encrypt
//
//  Created by Lik Dan on 11/10/22.
//

import SwiftUI

struct Selector: View {
    private let stageSelect: (Int) -> Void

    init(stageSelect: @escaping (Int) -> ()) {
        self.stageSelect = stageSelect
    }

    var body: some View {
        Menu("Select...") {
            Button("Lab4 Task1") {
                stageSelect(4_1)
            }
            Button("Lab4 Task2") {
                stageSelect(4_2)
            }
            Button("Lab6 Task1") {
                stageSelect(6_1)
            }
        }
    }
}
