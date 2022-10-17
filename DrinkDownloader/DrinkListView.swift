//
//  DrinkListView.swift
//  DrinkDownloader
//
//  Created by Nicky Taylor on 10/16/22.
//

import SwiftUI

struct DrinkListView: View {
    @ObservedObject var viewModel: DrinkListViewModel
    var body: some View {
        ScrollView {
            ForEach(viewModel.drinks) { drink in
                DrinkCellView(viewModel: viewModel, drink: drink)
            }
            .padding(.top, 24)
            .padding(.bottom, 120)
        }
        .background(Color.gray)
    }
}

struct DrinkListView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkListView(viewModel: DrinkListViewModel.preview())
    }
}
