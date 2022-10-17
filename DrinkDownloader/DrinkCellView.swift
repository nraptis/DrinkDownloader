//
//  DrinkCellView.swift
//  DrinkDownloader
//
//  Created by Nicky Taylor on 10/16/22.
//

import SwiftUI

struct DrinkCellView: View {
    
    @ObservedObject var viewModel: DrinkListViewModel
    let drink: Drink
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                titleRow()
                glassRow()
                ForEach(viewModel.ingreedients(for: drink)) { ingreedient in
                    ingreedientRow(ingreedient: ingreedient)
                }
                instructionsRow()
            }
        }
        .background(imageUnderlay())
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .background(cellBackground())
        .padding(.horizontal, 24)
        .padding(.vertical, 6)
    }
    
    private func titleRow() -> some View {
        HStack {
            Text(viewModel.name(for: drink))
                .font(.system(size: 34).bold())
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 24)
        .background(Color.blue.opacity(0.5))
    }
    
    private func glassRow() -> some View {
        HStack {
            ZStack {
                Circle()
                    .fill()
                    .foregroundColor(.blue)
                    .frame(width: 36, height: 36)
                Image(systemName: "wineglass")
                    .font(.system(size: 22))
                    .foregroundColor(.white)
            }
            Text(viewModel.glass(for: drink))
                .font(.system(size: 24))
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
    }
    
    private func ingreedientRow(ingreedient: DrinkListViewModel.IngreedientRowModel) -> some View {
        HStack {
            Text("\(ingreedient.measure): ")
                .font(.system(size: 18))
            Text(ingreedient.name)
                .font(.system(size: 18))
            Spacer()
            
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
        .background(Rectangle().stroke().foregroundColor(.gray))
    }
    
    private func instructionsRow() -> some View {
        HStack {
            Text(viewModel.instructions(for: drink))
                .font(.system(size: 18))
                .lineLimit(6)
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
    }
    
    @ViewBuilder
    private func imageUnderlay() -> some View {
        if let image = viewModel.image(for: drink) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(0.28)
        }
    }
    
    private func cellBackground() -> some View {
        RoundedRectangle(cornerRadius: 12)
            .fill()
            .foregroundColor(.white)
            .shadow(color: .black.opacity(0.6),
                    radius: 4.0,
                    x: -2.0,
                    y: 4.0)
    }
}

struct DrinkCellView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            DrinkCellView(viewModel: .init(), drink: Drink.preview())
            Spacer()
        }
        .background(Color.gray)
    }
}
