enum Primitives {
    static var header: String {
        """
        import UIKit

        private func image(_ name: String) -> UIImage {
            UIImage(named: name, in: .module, with: nil)!
        }
        """
    }

    static var newLine: String {
        newLines(1)
    }

    static var closingCurlyBrace: String {
        "}"
    }

    static func newLines(_ count: Int) -> String {
        Array(repeating: "\n", count: count).joined()
    }

    static func tabs(_ count: Int) -> String {
        Array(repeating: "    ", count: count).joined()
    }

    static func enumDeclaration(enumName: some StringProtocol) -> String {
        let symbolName = mapToSymbolName(for: enumName, capitalize: true)

        return "public enum \(symbolName) {"
    }

    static func image(assetName: some StringProtocol, path: some StringProtocol) -> String {
        let symbolName = mapToSymbolName(for: assetName, capitalize: false)

        return "public static var \(symbolName): UIImage { image(\"\(path)\") }"
    }

    private static func mapToSymbolName(for string: some StringProtocol, capitalize: Bool) -> String {
        var symbolName = string
            .prefix(1)
            .lowercased() + string.dropFirst()
        symbolName = symbolName
            .split(separator: " ")
            .enumerated()
            .map { index, part in
                let part = String(part)

                guard index != 0 || capitalize else { return part }

                return part
                    .prefix(1)
                    .uppercased() + part.dropFirst()
            }
            .joined()

        return symbolName
    }
}
