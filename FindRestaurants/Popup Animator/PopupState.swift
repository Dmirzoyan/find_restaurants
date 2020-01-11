//
//  PopupState.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

enum PopupState {
    case open, preview, closed
}

extension PopupState {
    
    var next: PopupState {
        switch self {
        case .closed:
            return .preview
        case .preview:
            return .open
        case .open:
            return .preview
        }
    }
}
