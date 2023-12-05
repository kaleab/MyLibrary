//
//  File.swift
//  
//
//  Created by Kal Y on 12/5/23.
//

import Foundation

public struct IPAddressData: Codable {
    var ip: String = "127.0.0.1"
    let city: String
    let region: String
    let country: String
    // Add more properties as needed
}
