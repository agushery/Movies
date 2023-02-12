//
//  ContentView.swift
//  Movies
//
//  Created by Agus Hery on 10/02/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var homePresenter: HomePresenter
    
    var body: some View {
        NavigationView {
            HomeView(presenter: homePresenter)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




