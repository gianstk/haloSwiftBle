import Foundation
import CoreBluetooth

struct TransferServices {
    static let UUID_A = CBUUID(string: "49535343-5D82-6099-9348-7AAC4D5FBC51")
    static let UUID_B = CBUUID(string: "49535343-C9D0-CC83-A44A-6FE238D06D33")
    
    static let UUID_TRANSPARENT_PRIVATE_SERVICE = CBUUID(string: "49535343-FE7D-4AE5-8FA9-9FAFD205E455")
    static let UUID_TRANSPARENT_TX_PRIVATE_CHAR = CBUUID(string: "49535343-1E4D-4BD9-BA61-23C647249616")
    static let UUID_TRANSPARENT_RX_PRIVATE_CHAR = CBUUID(string: "49535343-8841-43F4-A8D4-ECBE34729BB3")
}
