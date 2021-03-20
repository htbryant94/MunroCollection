import Foundation
import Shared

CSVParser.parseFile("Sources/Resources/munrotab_v6.2.csv") { result in
    switch result {
    case let .success(data):
        print("successfully parsed data with \(data.count) rows")
        let munros = MunroFactory(rows: data).makeMunros()
        print("number of valid munros: \(munros.count)")
        
        MunroService().fetch(
            munros,
            sortType: .name(.ascending),
            hillCategory: .munroTop,
            minHeight: 20,
            maxHeight: 1000
        ) { result in
            switch result {
            case let .success(results):
                print("results from service: \(results.count)")
            case let .failure(error):
                print("error: \(error)")
            }
        }
        
    case let .failure(error):
        print("parse failure: \(error)")
    }
}
