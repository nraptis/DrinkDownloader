//
//  DrinkDownloaderApp.swift
//  DrinkDownloader
//
//  Created by Nicky Taylor on 10/16/22.
//

import SwiftUI

@main
struct DrinkDownloaderApp: App {
    let drinkListViewModel = DrinkListViewModel()
    var body: some Scene {
        WindowGroup {
            DrinkListView(viewModel: drinkListViewModel)
        }
    }
}
