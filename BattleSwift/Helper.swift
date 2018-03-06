//
//  Helper.swift
//  BattleSwift
//
//  Created by Co5ta on 06/03/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

/// Protocol to count enum cases
protocol CaseCountable { }

/// Extension for CaseCountable which add the possibility to get a count var on enum
extension CaseCountable where Self : RawRepresentable, Self.RawValue == Int {
    /// Return the number of cases on an enum
    static var count: Int {
        var count = 0
        while let _ = Self(rawValue: count) { count+=1 }
        return count
    }
}
