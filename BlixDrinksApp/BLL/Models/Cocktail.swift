//
//  Drink.swift
//  BlixDrinksApp
//
//  Created by Festyk on 02/12/2024.
//
import Foundation

struct Cocktail: Decodable, Identifiable {

    let id: String
    let name: String?
    let category: String?
    let alcoholic: String?
    let glass: String?
    let instructions: String?
    let thumbnailUrl: String?
    
    let ingredientsWithMeasure: [(String, String)]?
   
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case category = "strCategory"
        case alcoholic = "strAlcoholic"
        case glass = "strGlass"
        case instructions = "strInstructions"
        case thumbnailUrl = "strDrinkThumb"
        case ingredientsWithMeasure
    }
    
    init(id: String, name: String?, category: String?, alcoholic: String?, glass: String?, instructions: String?, thumbnailUrl: String?) {
        self.id = id
        self.name = name
        self.category = category
        self.alcoholic = alcoholic
        self.glass = glass
        self.instructions = instructions
        self.thumbnailUrl = thumbnailUrl
        self.ingredientsWithMeasure = nil
    }
        
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.category = try container.decodeIfPresent(String.self, forKey: .category)
        self.alcoholic = try container.decodeIfPresent(String.self, forKey: .alcoholic)
        self.glass = try container.decodeIfPresent(String.self, forKey: .glass)
        self.instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
        self.thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
        self.ingredientsWithMeasure = Cocktail.extractIngredients(decoder: decoder)
    }
    
    private struct UnknownKeys: CodingKey, Comparable {
        var stringValue: String
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        
        init?(intValue: Int) {
            return nil
        }
        
        static func < (lhs: Cocktail.UnknownKeys, rhs: Cocktail.UnknownKeys) -> Bool {
            return lhs.stringValue < rhs.stringValue
        }
    }
    
    private static func extractIngredients(decoder: any Decoder) -> [(String, String)]? {
        guard let unkeyedContainer = try? decoder.container(keyedBy: UnknownKeys.self) else {
            return nil
        }
        
        var ingredients = [String]()
        var measurements = [String]()
        
        for key in unkeyedContainer.allKeys.sorted(by: {$0.stringValue.localizedStandardCompare($1.stringValue) == .orderedAscending}) {
            guard let key = UnknownKeys(stringValue: key.stringValue) else {
                continue
            }
            
            if (key.stringValue.starts(with: "strIngredient")) {
                if let decoded = try? unkeyedContainer.decodeIfPresent(String.self, forKey: key) {
                    ingredients.append(decoded)
                }
            } else if (key.stringValue.starts(with: "strMeasure")) {
                if let decoded = try? unkeyedContainer.decodeIfPresent(String.self, forKey: key) {
                    measurements.append(decoded)
                }
            }
        }
        return Array(zip(ingredients, measurements))
    }
}
