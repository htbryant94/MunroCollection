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
                    case let .success(data):
                        sut = MunroFactory(fileContents: data)
                    default: break
                    }
                }
            }
            
            context("parsing munros") {
                it("should return correct number of Munros") {
                    expect(sut.makeMunros().count) == 602
                }
            }
        }
    }
}
