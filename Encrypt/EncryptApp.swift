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
            let back = {
                stage = 0
            }

            switch stage {
            case 41: Lab4Task1(back: back)
            case 42: Lab4Task1(back: back)
            default: Selector { i in
                stage = i
            }
            }
        }
    }
}
