//
//  EncryptApp.swift
//  Encrypt
//
//  Created by Lik Dan on 11/10/22.
//

import SwiftUI

@main
struct EncryptApp: App {
    @State var stage = 0
    var body: some Scene {
        WindowGroup {
            switch stage {
            case 41: Lab4Task1()
            case 42: Lab4Task2()
            default: Selector { i in
                stage = i
            }
            }
        }
    }
}
