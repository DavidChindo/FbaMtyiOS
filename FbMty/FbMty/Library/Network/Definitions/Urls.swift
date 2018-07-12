//
//  Urls.swift
//  FbMty
//
//  Created by David Barrera on 5/24/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

class Urls: NSObject {

    static let API_FBMTY = "http://fibramty.hics.mx"
    
    static let API_LOGIN = API_FBMTY + "/token"
    static let API_holdingByUser = API_FBMTY + "/api/MySpace/holdingsByUser"
    static let API_register = API_FBMTY + "/api/Account/Register"
    static let API_payments = API_FBMTY + "/api/MySpace/paymentsByHolding/%d"
    static let API_sendTicket = API_FBMTY + "/api/MySpace/sendTicket"
    static let API_cancelTicket = API_FBMTY + "/api/MySpace/cancelTicket"
    static let API_deleteTicket = API_FBMTY + "/api/MySpace/deleteTicket"
    static let API_myTickets = API_FBMTY + "/api/MySpace/servicesByUserAndHolding/%d"
    static let API_maintenances = API_FBMTY + "/api/MySpace/maintenanceByHolding/%d"
    static let API_cajonesEstByUserAndHolding = API_FBMTY + "/api/MySpace/cajonesEstByUserAndHolding/%d"
    static let API_getHoldingUserParkingLotsTickets = API_FBMTY + "/api/MySpace/getHoldingUserParkingLotsTickets/%d"
    static let API_tarjetasEstByUserAndHolding = API_FBMTY + "/api/MySpace/tarjetasEstByUserAndHolding/%d"
    static let API_getHoldingUserParkingMembershipsTickets = API_FBMTY + "/api/MySpace/getHoldingUserParkingMembershipsTickets/%d"
    static let API_CortesiasEstByUserAndHolding = API_FBMTY + "/api/MySpace/CortesiasEstByUserAndHolding/%d"
    static let API_getHoldingUserParkingCardsTickets = API_FBMTY + "/api/MySpace/getHoldingUserParkingCardsTickets/%d"
    static let API_sendCajonesEstTickets = API_FBMTY + "/api/MySpace/sendCajonesEstTickets"
    static let API_sendTarjetasEstTickets = API_FBMTY + "/api/MySpace/sendTarjetasEstTickets"
    static let API_sendCortesiasEstTickets = API_FBMTY + "/api/MySpace/sendCortesiasEstTickets"
    static let API_LOGOUT = API_FBMTY + "/api/Account/Logout"
    static let API_messages = API_FBMTY + "/api/MySpace/getHoldingUserMessages/%d"
    static let API_sentMessage = API_FBMTY + "/api/MySpace/sendMessage"
    static let API_resetPassword = API_FBMTY + "/Home/ResetPassword"
}
