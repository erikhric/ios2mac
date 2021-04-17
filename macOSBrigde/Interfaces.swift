//
//  Interfaces.swift
//  macOSBrigde
//
//  Created by Hric, Erik on 16.04.21.
//

import Foundation

@objc(iOS2Mac)
public protocol iOS2Mac: NSObjectProtocol {
    init()
    var iosListener: mac2iOS? { get set }
    func createBarItem()
}

@objc(mac2iOS)
public protocol mac2iOS: NSObjectProtocol {
    func barItemClicked()
}
