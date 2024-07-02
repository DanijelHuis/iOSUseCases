//
//  Note.swift
//  SingleSourceOfTruthMVVM
//
//  Created by Danijel Huis on 02.07.2024..
//

import Foundation

public struct Note: Equatable {
    let id = UUID().uuidString
    var text: String
    var isCompleted = false
}
