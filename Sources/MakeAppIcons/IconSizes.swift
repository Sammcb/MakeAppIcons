//
//  IconSizes.swift
//  
//
//  Created by Samuel McBroom on 1/31/21.
//

import Foundation

enum MessagesIconSize: CaseIterable, CustomStringConvertible, Sizable {
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
		"\(Int(rawValue.width))x\(Int(rawValue.height))"
	}
}

enum tvOSIconSize: CaseIterable, CustomStringConvertible, Sizable {
	case App
	case App2x
	case AppStore
	
	var rawValue: NSSize {
		switch self {
		case .App:
			return NSSize(width: 400, height: 240)
		case .App2x:
			return NSSize(width: 800, height: 480)
		case .AppStore:
			return NSSize(width: 1280, height: 768)
		}
	}
	
	var description: String {
		"\(Int(rawValue.width))x\(Int(rawValue.height))"
	}
}

enum tvOSTopShelfSize: CaseIterable, CustomStringConvertible, Sizable {
	case TopShelf
	case TopShelf2x
	
	var rawValue: NSSize {
		switch self {
		case .TopShelf:
			return NSSize(width: 1920, height: 720)
		case .TopShelf2x:
			return NSSize(width: 3840, height: 1440)
		}
	}
	
	var description: String {
		"\(Int(rawValue.width))x\(Int(rawValue.height))"
	}
}

enum tvOSTopShelfWideSize: CaseIterable, CustomStringConvertible, Sizable {
	case TopShelfWide
	case TopShelfWide2x
	
	var rawValue: NSSize {
		switch self {
		case .TopShelfWide:
			return NSSize(width: 2320, height: 720)
		case .TopShelfWide2x:
			return NSSize(width: 4640, height: 1440)
		}
	}
	
	var description: String {
		"\(Int(rawValue.width))x\(Int(rawValue.height))"
	}
}
