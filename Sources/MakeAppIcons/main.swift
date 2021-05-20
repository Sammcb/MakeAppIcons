import ArgumentParser
import AppKit

struct MakeAppIcon: ParsableCommand {
	static let configuration = CommandConfiguration(abstract: "Generates assets needed to fill the AppIcon asset for iOS apps.")
	
	@Flag(help: "Generate icon for iMessage Sticker Pack.")
	var messages = false
	
	@Flag(help: "Fill in transparent areas with white.")
	var fill = false
	
	@Argument(help: "Path to source image.")
	var source: String
	
	@Argument(help: "Destination folder where generated icons are saved.")
	var destination: String
	
	func validate() throws {
		let iconURL = URL(fileURLWithPath: source)
		
		guard FileManager.default.fileExists(atPath: iconURL.path) else {
			throw ValidationError("'<icon-path>' must contain a valid image file.")
		}
		
		guard let icon = FileManager.default.contents(atPath: iconURL.path) else {
			throw ValidationError("'<icon-path>' must contain a valid image file.")
		}
		
		guard NSImage(data: icon) != nil else {
			throw ValidationError("'<icon-path>' must contain a valid image file.")
		}
	}
	
	func resize(image: NSImage, size: NSSize) -> Data {
		let imageRect = NSScreen.main!.convertRectFromBacking(NSRect(origin: .zero, size: size))
		let resized = NSImage(size: imageRect.size)
		resized.lockFocus()
		if size.width == size.height {
			image.draw(in: imageRect)
		} else {
			let landscape = size.width > size.height
			let scale = landscape ? size.width / size.height : size.height / size.width
			let croppedSize = landscape ? NSSize(width: image.size.width * scale, height: image.size.height) : NSSize(width: image.size.width, height: image.size.height * scale)
			let croppedOffset = landscape ? image.size.width - image.size.width * scale : image.size.height - image.size.height * scale
			let croppedOrigin = landscape ? CGPoint(x: croppedOffset / 2, y: 0) : CGPoint(x: 0, y: croppedOffset / 2)
			let croppedRect = CGRect(origin: croppedOrigin, size: croppedSize)
			
			if fill {
				NSColor.white.setFill()
				croppedRect.fill()
			}
			
			image.draw(in: imageRect, from: croppedRect, operation: .sourceOver, fraction: 1)
		}
		resized.unlockFocus()
		return resized.tiffRepresentation!
	}
	
	func run() throws {
		let fileManager = FileManager.default
		let iconURL = URL(fileURLWithPath: source)
		let destURL = URL(fileURLWithPath: destination, isDirectory: true)
		let icon = NSImage(data: fileManager.contents(atPath: iconURL.path)!)!
		
		if !fileManager.fileExists(atPath: destURL.path) {
			try fileManager.createDirectory(at: destURL, withIntermediateDirectories: true, attributes: nil)
		}
		
		if messages {
			for iconSize in MessagesIconSizes.allCases {
				let resizedIcon = resize(image: icon, size: iconSize.rawValue)
				fileManager.createFile(atPath: destURL.appendingPathComponent("icon\(iconSize).png", isDirectory: false).path, contents: resizedIcon, attributes: [.extensionHidden: true])
			}
		} else {
			for iconSize in AppIconSizes.allCases {
				let resizedIcon = resize(image: icon, size: iconSize.rawValue)
				fileManager.createFile(atPath: destURL.appendingPathComponent("icon\(iconSize).png", isDirectory: false).path, contents: resizedIcon, attributes: [.extensionHidden: true])
			}
		}
	}
}

MakeAppIcon.main()
