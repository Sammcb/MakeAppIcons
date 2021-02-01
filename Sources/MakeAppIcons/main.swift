import ArgumentParser
import AppKit

struct MakeAppIcon: ParsableCommand {
	static let configuration = CommandConfiguration(abstract: "Generates assets needed to fill the AppIcon asset for iOS apps.")
	
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
		image.draw(in: imageRect)
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
		
		for iconSize in IconSizes.allCases {
			let resizedIcon = resize(image: icon, size: iconSize.rawValue)
			fileManager.createFile(atPath: destURL.appendingPathComponent("icon\(iconSize).png", isDirectory: false).path, contents: resizedIcon, attributes: [.extensionHidden: true])
		}
	}
}

MakeAppIcon.main()
