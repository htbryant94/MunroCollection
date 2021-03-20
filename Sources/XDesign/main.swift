import Foundation
import Shared

CSVParser.parseFile("Sources/Resources/munrotab_v6.2.csv") { result in
    switch result {
    case let .success(data):
        print("successfully parsed data with \(data.count) rows")
        let munros = MunroFactory(rows: data).makeMunros()
        print("number of valid munros: \(munros.count)")
        
        let munroTops = MunroFilter.byHillCategory(munros: munros, hillCategory: .munroTop)
        print("number of Munro Tops: \(munroTops.count)")
        
        let munrosSortedByName = MunroSort.byName(munros: munros)
        print("--- Sorted by ascending order ---")
        print("First: \(munrosSortedByName[0].name)")
        print("Last: \(munrosSortedByName.last!.name)")
        
        
    case let .failure(error):
        print("parse failure: \(error)")
    }
}
