import Foundation
import Shared

MunroCollection().get(
    sortType: .name(.ascending),
    hillCategory: .munro,
    minHeight: 500,
    maxHeight: 2000,
    limit: nil
) { result in
    switch result {
    case let .success(munros):
        print("successfully returned munros: \(munros.count)")
    case let .failure(error):
        print(error)
    }
}
