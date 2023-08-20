
import Foundation

class Youtube {
    static var key: String = "GYkq9Rgoj8E"
    static var title: String = "WWDC 2023"
}


struct Collection {
    
    static let identifiet = "MusicCV"
    static let spacingWitdh: CGFloat = 20
    static let cellColumns: CGFloat = 4
}

enum Years: Int {
    case three = 0
    case two = 1
    case one = 2
    case zero = 3
    
    var youtube: String {
        switch self {
        case .three:
            return "GYkq9Rgoj8E"
        case .two:
            return "q5D55G7Ejs8"
        case .one:
            return "0TD96VTf0Xs"
        case .zero:
            return "GEZhD3J89ZE"
        }
    }
    
    var applePage: String {
        switch self {
        case .three:
            return "https://developer.apple.com/kr/wwdc23/"
        case .two:
            return "https://www.apple.com/kr/newsroom/2022/06/wwdc22-highlights/"
        case .one:
            return "https://www.apple.com/kr/newsroom/2021/06/apple-advances-personal-health-by-introducing-secure-sharing-and-new-insights/"
        case .zero:
            return "https://www.apple.com/kr/newsroom/2020/06/wwdc20-highlights/"
        }
    }
}
