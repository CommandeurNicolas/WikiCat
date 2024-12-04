//
//  Device.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 02/12/2024.
//

import UIKit

enum Device {
    //MARK: Current device type: iPhone, iPad, Mac, Vision
    enum Devicetype{
        case iphone, ipad, mac, vision
    }
    
    static var deviceType:Devicetype{
        #if os(macOS)
            return .mac
        #else
            if UIDevice.current.userInterfaceIdiom == .pad {
                return .ipad
            } else if UIDevice.current.userInterfaceIdiom == .vision {
                return .vision
            } else {
                return .iphone
            }
        #endif
    }
}
