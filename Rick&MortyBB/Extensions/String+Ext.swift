//
//  String+Ext.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 26/10/2023.
//

import Foundation
import SwiftUI

extension String {
    var formatEpisode: String {
        if let stringRange = self.range(of: "E") {
            let episodeString = self[stringRange.upperBound...]
            return String(episodeString)
        }
        return self
    }
    
    var formatSeason: String {
        let seasonString = String(Int(self.dropFirst()) ?? 0)
        return "Season \(seasonString)"
    }
}
