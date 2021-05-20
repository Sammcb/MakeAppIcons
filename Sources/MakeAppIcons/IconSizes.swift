//
//  IconSizes.swift
//  
//
//  Created by Samuel McBroom on 1/31/21.
//

import Foundation

enum AppIconSizes: CaseIterable, CustomStringConvertible {
	case iPhoneNotification2x
	case iPhoneNotification3x
	case iPhoneSettings2x
	case iPhoneSettings3x
	case iPhoneSpotlight2x
	case iPhoneSpotlight3x
	case iPhoneApp2x
	case iPhoneApp3x
	case iPadNotification1x
	case iPadNotification2x
	case iPadSettings1x
	case iPadSettings2x
	case iPadSpotlight1x
	case iPadSpotlight2x
	case iPadApp1x
	case iPadApp2x
	case iPadProApp2x
	case AppStore1x
	
	var rawValue: NSSize {
		switch self {
			case .iPhoneNotification2x:
				return NSSize(width: 40, height: 40)
			case .iPhoneNotification3x:
				return NSSize(width: 60, height: 60)
			case .iPhoneSettings2x:
				return NSSize(width: 58, height: 58)
			case .iPhoneSettings3x:
				return NSSize(width: 87, height: 87)
			case .iPhoneSpotlight2x:
				return NSSize(width: 80, height: 80)
			case .iPhoneSpotlight3x:
				return NSSize(width: 120, height: 120)
			case .iPhoneApp2x:
				return NSSize(width: 120, height: 120)
			case .iPhoneApp3x:
				return NSSize(width: 180, height: 180)
			case .iPadNotification1x:
				return NSSize(width: 20, height: 20)
			case .iPadNotification2x:
				return NSSize(width: 40, height: 40)
			case .iPadSettings1x:
				return NSSize(width: 29, height: 29)
			case .iPadSettings2x:
				return NSSize(width: 58, height: 58)
			case .iPadSpotlight1x:
				return NSSize(width: 40, height: 40)
			case .iPadSpotlight2x:
				return NSSize(width: 80, height: 80)
			case .iPadApp1x:
				return NSSize(width: 76, height: 76)
			case .iPadApp2x:
				return NSSize(width: 152, height: 152)
			case .iPadProApp2x:
				return NSSize(width: 167, height: 167)
			case .AppStore1x:
				return NSSize(width: 1024, height: 1024)
		}
	}
	
	var description: String {
		return "\(Int(rawValue.width))x\(Int(rawValue.height))"
	}
}

enum MessagesIconSizes: CaseIterable, CustomStringConvertible {
	case iPhoneSettings2x
	case iPhoneSettings3x
	case MessagesiPhone2x
	case MessagesiPhone3x
	case iPadSettings
	case MessagesiPad
	case MessagesiPadPro
	case AppStoreiOS
	case MessagesAppStore
	case Messages2x27
	case Messages3x27
	case Messages2x32
	case Messages3x32
	
	var rawValue: NSSize {
		switch self {
			case .iPhoneSettings2x:
				return NSSize(width: 58, height: 58)
			case .iPhoneSettings3x:
				return NSSize(width: 87, height: 87)
			case .MessagesiPhone2x:
				return NSSize(width: 120, height: 90)
			case .MessagesiPhone3x:
				return NSSize(width: 180, height: 135)
			case .iPadSettings:
				return NSSize(width: 58, height: 58)
			case .MessagesiPad:
				return NSSize(width: 134, height: 100)
			case .MessagesiPadPro:
				return NSSize(width: 148, height: 110)
			case .AppStoreiOS:
				return NSSize(width: 1024, height: 1024)
			case .MessagesAppStore:
				return NSSize(width: 1024, height: 768)
			case .Messages2x27:
				return NSSize(width: 54, height: 40)
			case .Messages3x27:
				return NSSize(width: 81, height: 60)
			case .Messages2x32:
				return NSSize(width: 64, height: 48)
			case .Messages3x32:
				return NSSize(width: 96, height: 72)
		}
	}
	
	var description: String {
		return "\(Int(rawValue.width))x\(Int(rawValue.height))"
	}
}
