
import SwiftUI

struct Pokemon:Identifiable, Hashable {
    var id = UUID()
    var name: String = ""
    var type: [String] = []
}
