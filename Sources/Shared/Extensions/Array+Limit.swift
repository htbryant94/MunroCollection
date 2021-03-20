 public extension Array {
    func limit(_ max: Int) -> Self {
        let arraySlice = prefix(max)
        return Self(arraySlice)
    }
 }
