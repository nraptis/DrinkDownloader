//
//  DrinkListViewModel.swift
//  DrinkDownloader
//
//  Created by Nicky Taylor on 10/16/22.
//

import SwiftUI

class DrinkListViewModel: ObservableObject {
    
    struct IngreedientRowModel: Identifiable {
        let id: Int
        let name: String
        let measure: String
    }
    
    static func preview() -> DrinkListViewModel {
        let result = DrinkListViewModel()
        let responseModel = ResponseModel.preview()
        result.drinks = responseModel.drinks
        return result
    }
    
    @Published var drinks = [Drink]()
    @Published var imageDict = [Drink: UIImage]()
    
    init() {
        Task {
            do {
                try await downloadDrinks()
            } catch let error {
                print("Drink Download Error: \(error.localizedDescription)")
            }
        }
    }
    
    func downloadDrinks() async throws {
        
        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=gin"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        print("Downloading from: \(url.absoluteString)")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("Response Code: \(httpResponse.statusCode)")
        }
        
        print("Downloaded \(data.count) bytes of data!")
        
        let responseModel = try JSONDecoder().decode(ResponseModel.self, from: data)
        
        await MainActor.run {
            self.drinks = responseModel.drinks
        }
        
        await downloadImages()
    }
    
    func downloadImages() async {
        await withThrowingTaskGroup(of: Void.self) { group -> Void in
            for drink in drinks {
                group.addTask {
                 
                    guard let urlString = drink.strDrinkThumb else {
                        throw URLError(.unsupportedURL)
                    }
                    
                    guard let url = URL(string: urlString) else {
                        throw URLError(.badURL)
                    }
                    
                    let (data, _) = try await URLSession.shared.data(from: url)
                    
                    guard let image = UIImage(data: data) else {
                        throw URLError(.cannotDecodeRawData)
                    }
                    
                    print("Image Downloaded: \(image.size.width) x \(image.size.height)")
                    
                    await MainActor.run {
                        self.imageDict[drink] = image
                    }
                    
                }
            }
        }
        
    }
    
    func name(for drink: Drink) -> String {
        drink.strDrink
    }
    
    func glass(for drink: Drink) -> String {
        drink.strGlass ?? ""
    }
    
    func instructions(for drink: Drink) -> String {
        drink.strInstructions ?? ""
    }
    
    func image(for drink: Drink) -> UIImage? {
        if let result = imageDict[drink] {
            return result
        }
        return nil
    }
    
    func ingreedients(for drink: Drink) -> [IngreedientRowModel] {
        var result = [IngreedientRowModel]()
        let names = ingreedientNameList(for: drink)
        let measures = ingreedientMeasureList(for: drink)
        let count = min(names.count, measures.count)
        for index in 0..<count {
            let name = names[index]
            let measure = measures[index]
            let rowModel = IngreedientRowModel(id: index,
                                               name: name,
                                               measure: measure)
            result.append(rowModel)
        }
        
        return result
    }
    
    func ingreedientNameList(for drink: Drink) -> [String] {
        var result = [String]()
        if let name = drink.strIngredient1 { result.append(name) }
        if let name = drink.strIngredient2 { result.append(name) }
        if let name = drink.strIngredient3 { result.append(name) }
        if let name = drink.strIngredient4 { result.append(name) }
        if let name = drink.strIngredient5 { result.append(name) }
        if let name = drink.strIngredient6 { result.append(name) }
        if let name = drink.strIngredient7 { result.append(name) }
        if let name = drink.strIngredient8 { result.append(name) }
        return result
    }
    
    func ingreedientMeasureList(for drink: Drink) -> [String] {
        var result = [String]()
        if let measure = drink.strMeasure1 { result.append(measure) }
        if let measure = drink.strMeasure2 { result.append(measure) }
        if let measure = drink.strMeasure3 { result.append(measure) }
        if let measure = drink.strMeasure4 { result.append(measure) }
        if let measure = drink.strMeasure5 { result.append(measure) }
        if let measure = drink.strMeasure6 { result.append(measure) }
        if let measure = drink.strMeasure7 { result.append(measure) }
        if let measure = drink.strMeasure8 { result.append(measure) }
        return result
    }
    
}
