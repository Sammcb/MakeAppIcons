import XCTest
import class Foundation.Bundle

final class MakeAppIconsTests: XCTestCase {
	func testValidIcon() throws {
		let binary = productsDirectory.appendingPathComponent("makeAppIcons")
		
		let process = Process()
		process.executableURL = binary
		process.arguments = [Bundle.module.path(forResource: "icon", ofType: "png")!, Bundle.module.resourcePath!]
		
		let pipe = Pipe()
		process.standardError = pipe
		
		try process.run()
		process.waitUntilExit()
		
		let data = pipe.fileHandleForReading.readDataToEndOfFile()
		let output = String(data: data, encoding: .utf8)
		
		XCTAssertEqual(output, "")
	}
	
	func testInvalidExtension() throws {
		let binary = productsDirectory.appendingPathComponent("makeAppIcons")
		
		let process = Process()
		process.executableURL = binary
		process.arguments = [Bundle.module.path(forResource: "icon", ofType: "txt")!, Bundle.module.resourcePath!]
		
		
		let pipe = Pipe()
		process.standardError = pipe
		
		try process.run()
		process.waitUntilExit()
		
		let data = pipe.fileHandleForReading.readDataToEndOfFile()
		let output = String(data: data, encoding: .utf8)
		
		XCTAssertEqual(output, "Error: \'<icon-path>\' must contain a valid image file.\nUsage: make-app-icon <source> <destination> [--platform <platform>] [--background]\n  See \'make-app-icon --help\' for more information.\n")
	}
	
	func testInvalidPath() throws {
		let binary = productsDirectory.appendingPathComponent("makeAppIcons")
		
		let process = Process()
		process.executableURL = binary
		process.arguments = ["/invalid/path.png", "/invalid/"]
		
		
		let pipe = Pipe()
		process.standardError = pipe
		
		try process.run()
		process.waitUntilExit()
		
		let data = pipe.fileHandleForReading.readDataToEndOfFile()
		let output = String(data: data, encoding: .utf8)
		
		XCTAssertEqual(output, "Error: \'<icon-path>\' must contain a valid image file.\nUsage: make-app-icon <source> <destination> [--platform <platform>] [--background]\n  See \'make-app-icon --help\' for more information.\n")
	}
	
	/// Returns path to the built products directory.
	var productsDirectory: URL {
		#if os(macOS)
		for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
			return bundle.bundleURL.deletingLastPathComponent()
		}
		fatalError("couldn't find the products directory")
		#else
		return Bundle.main.bundleURL
		#endif
	}
	
	static var allTests = [
		("testValidIcon", testValidIcon),
		("testInvalidExtension", testInvalidExtension),
		("testInvalidPath", testInvalidPath)
	]
}
