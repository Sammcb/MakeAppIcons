import ArgumentParser
import AppKit

@main
struct MakeAppIcon: ParsableCommand {
	enum Platform: String, ExpressibleByArgument, CaseIterable {
		case ios
		case messages
		case tvos
		case topshelf
		case topshelfwide
	}
	
	static let configuration = CommandConfiguration(abstract: "Generates assets needed to fill the AppIcon asset for iOS apps.")
	
	@Argument(help: "Path to source image.")
	var source: String
	
	@Argument(help: "Destination folder where generated icons are saved.")
	var destination: String
	
	@Option(help: "Generate icons for the specified platform.")
	var platform: Platform = .ios
	
	@Flag(help: "Icon is background layer of tvOS icon.")
	var background = false
	
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
	
	private func resize(image: CGImage, size: NSSize, removeAlpha: Bool) -> Data {
		let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)!
		let bitmapInfo = removeAlpha ? CGImageAlphaInfo.noneSkipLast.rawValue : CGImageAlphaInfo.premultipliedLast.rawValue
		let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo)!
		context.setAllowsAntialiasing(true)
		context.interpolationQuality = .high
		
		let drawRect = NSRect(origin: .zero, size: size)
		
		if Double(image.width) / size.width == Double(image.height) / size.height {
			context.draw(image, in: drawRect)
		} else {
            let scale = size.width > size.height ? Double(image.width) / size.width : Double(image.height) / size.height
            let cropOrigin = size.width > size.height ? CGPoint(x: 0, y: (image.height - Int(size.height * scale)) / 2) : CGPoint(x: (image.width - Int(size.width * scale)) / 2, y: 0)
            let cropSize = size.width > size.height ? CGSize(width: image.width, height: Int(size.height * scale)) : CGSize(width: Int(size.width * scale), height: image.width)
            let cropRect = CGRect(origin: cropOrigin, size:cropSize)
            let croppedImage = image.cropping(to: cropRect)!
            
            context.draw(croppedImage, in: drawRect)
		}
		
		let result = NSImage(cgImage: context.makeImage()!, size: size)
		let resultBitmap = NSBitmapImageRep(data: result.tiffRepresentation!)!
		return resultBitmap.representation(using: .png, properties: [:])!
	}
	
	private func generateIcons(sizes: [Sizable], at destURL: URL, removeAlpha: Bool = true) throws {
		let iconDataFile = CGDataProvider(url: URL(fileURLWithPath: source) as CFURL)!
		let icon = CGImage(pngDataProviderSource: iconDataFile, decode: nil, shouldInterpolate: false, intent: .defaultIntent)!
		
		for iconSize in sizes {
			let resizedIcon = resize(image: icon, size: iconSize.rawValue, removeAlpha: removeAlpha)
			FileManager.default.createFile(atPath: destURL.appendingPathComponent("icon\(iconSize).png", isDirectory: false).path, contents: resizedIcon, attributes: [.extensionHidden: true])
		}
	}
	
	func run() throws {
		let destURL = URL(fileURLWithPath: destination, isDirectory: true)
		
		if !FileManager.default.fileExists(atPath: destURL.path) {
			try FileManager.default.createDirectory(at: destURL, withIntermediateDirectories: true, attributes: nil)
		}
		
		switch platform {
		case .ios:
			try generateIcons(sizes: iOSIconSize.allCases, at: destURL)
		case .messages:
			try generateIcons(sizes: MessagesIconSize.allCases, at: destURL)
		case .tvos:
			try generateIcons(sizes: tvOSIconSize.allCases, at: destURL, removeAlpha: background)
		case .topshelf:
			try generateIcons(sizes: tvOSTopShelfSize.allCases, at: destURL)
		case  .topshelfwide:
			try generateIcons(sizes: tvOSTopShelfWideSize.allCases, at: destURL)
		}
	}
}
