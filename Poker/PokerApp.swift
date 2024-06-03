//
//  PokerApp.swift
//  Poker
//
//  Created by Abby Nayeri  on 2024-05-30.
//

import SwiftUI

@main
struct PokerApp: App {
    
    @State private var viewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
        }.windowStyle(.plain)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
