import Foundation
import Shared

CSVParser.parseFile("Sources/Resources/munrotab_v6.2.csv") { result in
    switch result {
    case let .success(data):
        print("successfully parsed data: \(data.count)")
        
    case let .failure(error):
        print("parse failure: \(error)")
    }
}
