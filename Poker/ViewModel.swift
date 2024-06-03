//
//  ViewModel.swift
//  Poker
//
//  Created by Abby Nayeri  on 2024-06-03.
//

import Foundation
import Observation

enum FlowSate {
    case idle
    case intro
    case projectileFlying
    case updateWallArt
}

@Observable
class ViewModel {
    
    var flowState = FlowSate.idle
}
