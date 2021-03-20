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
                var actualMunros: [Munro]!
                var expectedFirstMunro: Munro!
     
                beforeEach {
                    actualMunros = sut.makeMunros()
                    expectedFirstMunro = Munro(
                        name: "Ben Chonzie",
                        hillCategory: .munro,
                        height: 931
                    )
                }
                
                it("should return correct number of Munros based off Post 1997 column") {
                    expect(actualMunros.count) == 509
                }
                
                it("should have correct values") {
                    expect(actualMunros.first) == expectedFirstMunro
                }
            }
        }
    }
}
