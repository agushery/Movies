//
//  MoviesApp.swift
//  Movies
//
//  Created by Agus Hery on 10/02/23.
//

import SwiftUI

@main
struct MoviesApp: App {
    
    let homePresenter = HomePresenter(homeUseCase: Injection.init().provideHome())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homePresenter)
        }
    }
}
