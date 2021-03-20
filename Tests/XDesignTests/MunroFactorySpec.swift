import Nimble
import Quick
@testable import Shared

class MunroFactorySpec: QuickSpec {
    override func spec() {
        describe("CSVModel") {
            var sut: MunroFactory!

            beforeEach {
                CSVParser.parseFile("Sources/Resources/munrotab_v6.2.csv") { result in
                    switch result {
                    case let .success(rows):
                        print(rows)
                        sut = MunroFactory(rows: rows)
                    default: break
                    }
                }
            }
            
            context("parsing munros") {
                it("should return correct number of Munros based off Post 1997 column") {
                    expect(sut.makeMunros().count) == 509
                }
            }
        }
    }
}
