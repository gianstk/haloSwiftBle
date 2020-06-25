import Foundation


func receiveNewBytes(newBytes: [UInt8]) {
    let byteData = newBytes
    // packet length has to be longer than grater than header length
//    if (byteData.count < HEADER_LENGTH) {
//        print("FFFFFFF")
//    }
    
    let byteDataCheckLength = byteData.count - HEADER_LENGTH
    print("data check length:", byteDataCheckLength)
    
    //===============================================================
    //  ALL CHECKING
    //===============================================================
    // assume packet is correct
    if (byteData[0] != PREAMBLE1 || byteData[1] != PREAMBLE2) {
        return
    }
    
    let lenByte = Int(byteData[2])
    let payloadStartIndex = 0 + HEADER_LENGTH
    let payloadEndIndex = 0 + HEADER_LENGTH + lenByte
    let payload:[UInt8] = Array(byteData[payloadStartIndex..<payloadEndIndex])
//    print("--------------------------------------------------------------------------------")
    print("PAYLOAD:", printHexa(data: payload))
    inspectPayload(payload: payload);
    print("--------------------------------------------------------------------------------")
}


func inspectPayload(payload: [UInt8]) {
    let data_id: UInt8 = payload[0]
    switch data_id {
    case DID_DEVICE_PARAM1:
        print("======= DID_DEVICE_PARAM1 =======")
        let params = Array(payload[1..<payload.count])
        processUnitParams(payload: params)
    case DID_PROMPT_MESSAGE:
        print("DID_PROMPT_MESSAGE")
    default:
        print("======= UNKNOWN INSPECT PAYLOAD =======")
    }
}



func processUnitParams(payload: [UInt8]) {
    var i = 0
//    var actualVal: Int = 0
//    var isCycleParams: Bool = false
//    var isMonParams: Bool = false
//    var hasTestParams: Bool = false
    
    while (i + 2 < payload.count) {
        switch payload[i] {
        case DID_MOTOR_RPM:
            print("DID MOTOR RPM:", get2BytesUInt16(val1: payload[i+1], val2: payload[i+2]))
            break
        case DID_MOTOR_CURRENT:
            print("DID_MOTOR_CURRENT:", get2BytesInt16(val1: payload[i+1], val2: payload[i+2]))
            break
        case DID_MOTOR_TEMP:
            print("DID_MOTOR_TEMP:", get2BytesInt16(val1: payload[i+1], val2: payload[i+2]))
            break
        case DID_BATT_VOLTAGE:
            print("DID_BATT_VOLTAGE:", get2BytesUInt16(val1: payload[i+1], val2: payload[i+2]))
            break
        case DID_BATT_CURRENT:
            print("DID_BATT_CURRENT:", get2BytesInt16(val1: payload[i+1], val2: payload[i+2]))
            break
        case DID_BATT_TEMP:
            print("DID_BATT_TEMP:", get2BytesInt16(val1: payload[i+1], val2: payload[i+2]))
            break
        case DID_PRESSURE:
            print("DID_PRESSURE:", get2BytesInt16(val1: payload[i+1], val2: payload[i+2]))
            break
        case DID_BREATHING_RATE:
            print("DID_BREATHING_RATE:", get2BytesUInt16(val1: payload[i+1], val2: payload[i+2]))
            break
        case DID_BREATHING_EFFORT:
            print("DID_BREATHING_EFFORT:", get2BytesUInt16(val1: payload[i+1], val2: payload[i+2]))
            break
        case DID_BATT_STATE:
            print("DID_BATT_STATE:", get2BytesInt16(val1: payload[i+1], val2: payload[i+2]))
            break
        case DID_VIN_VOLTAGE:
            print("DID_VIN_VOLTAGE:", get2BytesInt16(val1: payload[i+1], val2: payload[i+2]))
            break
        case DID_FAULT_CODE:
            print("DID_FAULT_CODE:", get2BytesInt16(val1: payload[i+1], val2: payload[i+2]))
            break
        case DID_MOTOR_STATE:
            print("DID_MOTOR_STATE:", get2BytesUInt16(val1: payload[i+1], val2: payload[i+2]))
            break
        case DID_FLOWX10:
            print("DID_FLOWX10:", get2BytesUInt16(val1: payload[i+1], val2: payload[i+2]))
            break
        case DID_RESULT_MOTOR_ADC_OFFSET:
            print("========= DID_RESULT_MOTOR_ADC_OFFSET =========")
            break
        
        default:
            // unknown token
            print("unknown token \(payload[i])")
        }
        
        i += 3
    }
}




// HELPER FUNCTION FOR BYTE'S MANIPULATION
func printHexa(data: [UInt8]) -> String {
    var hexaString:String = ""
    for i in 0..<(data.count) {
        hexaString += String(format:"%02X", data[i])
        if i+1 < data.count {
            hexaString += ":"
        }
    }
    return hexaString
}

func get2BytesUInt16(val1: UInt8, val2: UInt8) -> UInt16 {
    return UInt16(val1)*256 + UInt16(val2)
}

func get2BytesInt16(val1: UInt8, val2: UInt8) -> Int16 {
    let str = String(format:"%02X", val1) + String(format:"%02X", val2)
    return Int16(bitPattern: UInt16(str, radix: 16) ?? 0)
}
