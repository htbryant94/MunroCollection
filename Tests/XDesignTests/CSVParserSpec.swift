import Quick
import Nimble
@testable import Shared

class CSVParserSpec: QuickSpec {
    override func spec() {
        describe("CSVParser") {
            context("parseFile") {
                context("when filePath exists") {
                    it("should return data") {
                        CSVParser.parseFile("Sources/Resources/munrotab_v6.2.csv") { result in
                            switch result {
                            case let .success(actual):
                                expect(actual).notTo(beNil())
                                
                            default:
                                fail()
                            }
                        }
                    }
                }
                
                context("when filePath does not exist") {
                    it("should return error with relevant localized description") {
                        CSVParser.parseFile("some/invalid/path") { result in
                            switch result {
                            case .success:
                                fail()

                            case let .failure(error):
                                expect(error.localizedDescription) == "The file “path” couldn’t be opened because there is no such file."
                            }
                        }
                    }
                }
            }
        }
    }
}
