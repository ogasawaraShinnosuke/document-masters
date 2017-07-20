protocol Currency {
    var name: String { get }
    var code: Node { get }
    var shareAverage: Int? { get }
}

protocol Node {
    
}

enum CryptoNode: Node {
    case none
    case btc
}

class CryptoCurrency: Currency {
    var name: String
    var code: Node = CryptoNode.none
    var shareAverage: Int? = nil
    
    init(name: String, code: CryptoNode, shareAverage: Int) {
        self.name = name
        self.code = code
        self.shareAverage = shareAverage
    }
    
    func isStrong<Strong>() -> Strong {
        return ((self.shareAverage ?? 0) > 30) as! Strong
    }
    
    func toString<StringElement>() -> StringElement {
        return "name=\(name), code=\(code), shareAverage=\(shareAverage ?? 0), isStrong=\(isStrong() as Any)" as! StringElement
    }
}
var cc = CryptoCurrency(name: "BitCoin", code: CryptoNode.btc, shareAverage: 40)
print(cc.toString())

