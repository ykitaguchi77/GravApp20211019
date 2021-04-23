//
//  CorneaAppApp.swift
//  CorneaApp
//
//  Created by Yoshiyuki Kitaguchi on 2021/04/18.
//

import SwiftUI

@main

struct CorneaAppApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(User())
        }
    }
}
