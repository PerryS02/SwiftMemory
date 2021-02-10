//
//  Array+Only.swift
//  Test
//
//  Created by Perry Sykes on 1/31/21.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first: nil
    }
}
