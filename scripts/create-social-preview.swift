import AppKit
import CoreText

let fileManager = FileManager.default
let root = URL(fileURLWithPath: fileManager.currentDirectoryPath)
let canvasSize = NSSize(width: 1200, height: 630)

for fontPath in [
    "assets/fonts/fraunces-800.ttf",
    "assets/fonts/source-sans-3-400.ttf",
    "assets/fonts/source-sans-3-600.ttf",
    "assets/fonts/source-sans-3-700.ttf"
] {
    CTFontManagerRegisterFontsForURL(root.appendingPathComponent(fontPath) as CFURL, .process, nil)
}

func color(_ hex: UInt32) -> NSColor {
    NSColor(
        red: CGFloat((hex >> 16) & 0xff) / 255,
        green: CGFloat((hex >> 8) & 0xff) / 255,
        blue: CGFloat(hex & 0xff) / 255,
        alpha: 1
    )
}

func font(_ family: String, _ size: CGFloat, fallbackWeight: NSFont.Weight) -> NSFont {
    NSFont(name: family, size: size) ?? NSFont.systemFont(ofSize: size, weight: fallbackWeight)
}

func drawText(_ text: String, in rect: NSRect, font: NSFont, color: NSColor, lineHeight: CGFloat? = nil) {
    let paragraph = NSMutableParagraphStyle()
    if let lineHeight {
        paragraph.minimumLineHeight = lineHeight
        paragraph.maximumLineHeight = lineHeight
    }
    (text as NSString).draw(
        with: rect,
        options: [.usesLineFragmentOrigin, .usesFontLeading],
        attributes: [.font: font, .foregroundColor: color, .paragraphStyle: paragraph]
    )
}

func drawPhone(from relativePath: String, in rect: NSRect, rotation: CGFloat) {
    guard let image = NSImage(contentsOf: root.appendingPathComponent(relativePath)) else {
        fatalError("Missing source image: \(relativePath)")
    }

    NSGraphicsContext.saveGraphicsState()
    let transform = NSAffineTransform()
    transform.translateX(by: rect.midX, yBy: rect.midY)
    transform.rotate(byDegrees: rotation)
    transform.translateX(by: -rect.midX, yBy: -rect.midY)
    transform.concat()

    let shadow = NSShadow()
    shadow.shadowColor = NSColor.black.withAlphaComponent(0.24)
    shadow.shadowBlurRadius = 24
    shadow.shadowOffset = NSSize(width: 0, height: -10)
    shadow.set()

    let frame = NSBezierPath(roundedRect: rect, xRadius: 46, yRadius: 46)
    color(0x16191f).setFill()
    frame.fill()

    NSGraphicsContext.current?.shouldAntialias = true
    frame.addClip()
    let source = NSRect(x: 82, y: 0, width: 1126, height: 2150)
    image.draw(in: rect.insetBy(dx: 8, dy: 8), from: source, operation: .sourceOver, fraction: 1)
    NSGraphicsContext.restoreGraphicsState()
}

let image = NSImage(size: canvasSize)
image.lockFocus()

let background = NSGradient(colors: [color(0xfff7e9), color(0xffead1), color(0xfbd1c0)])!
background.draw(in: NSRect(origin: .zero, size: canvasSize), angle: -18)

color(0xf58220).withAlphaComponent(0.11).setFill()
NSBezierPath(ovalIn: NSRect(x: 770, y: 320, width: 520, height: 520)).fill()
color(0x0e86e8).withAlphaComponent(0.08).setFill()
NSBezierPath(ovalIn: NSRect(x: 650, y: -210, width: 590, height: 590)).fill()

let navy = color(0x0b1730)
let orange = color(0xf58220)
let slate = color(0x46566d)

let markRect = NSRect(x: 68, y: 517, width: 58, height: 58)
guard let brandMark = NSImage(contentsOf: root.appendingPathComponent("assets/not-there-yet-mark.svg")) else {
    fatalError("Missing brand mark")
}
brandMark.draw(in: markRect)
drawText("NOT THERE YET", in: NSRect(x: 143, y: 527, width: 470, height: 42), font: font("Source Sans 3", 28, fallbackWeight: .bold), color: navy)

drawText(
    "Make the miles\nmore fun.",
    in: NSRect(x: 66, y: 273, width: 590, height: 228),
    font: font("Fraunces", 76, fallbackWeight: .heavy),
    color: navy,
    lineHeight: 83
)
drawText(
    "A family road-trip game for the miles\nbetween here and there.",
    in: NSRect(x: 70, y: 174, width: 570, height: 82),
    font: font("Source Sans 3", 29, fallbackWeight: .regular),
    color: slate,
    lineHeight: 37
)

let swiftPill = NSRect(x: 68, y: 66, width: 394, height: 58)
NSColor.white.withAlphaComponent(0.76).setFill()
NSBezierPath(roundedRect: swiftPill, xRadius: 29, yRadius: 29).fill()
orange.setFill()
NSBezierPath(ovalIn: NSRect(x: 84, y: 79, width: 32, height: 32)).fill()
drawText("S", in: NSRect(x: 94, y: 83, width: 17, height: 22), font: font("Source Sans 3", 16, fallbackWeight: .bold), color: .white)
drawText(
    "Designed & Developed in SwiftUI",
    in: NSRect(x: 129, y: 80, width: 316, height: 34),
    font: font("Source Sans 3", 21, fallbackWeight: .semibold),
    color: navy
)

drawPhone(
    from: "assets/app-store/exports/iphone-6.9/04.png",
    in: NSRect(x: 705, y: -96, width: 292, height: 594),
    rotation: -5
)
drawPhone(
    from: "assets/app-store/exports/iphone-6.9/01.png",
    in: NSRect(x: 918, y: -44, width: 292, height: 594),
    rotation: 4
)

image.unlockFocus()

guard
    let tiff = image.tiffRepresentation,
    let bitmap = NSBitmapImageRep(data: tiff),
    let png = bitmap.representation(using: .png, properties: [.compressionFactor: 0.9])
else {
    fatalError("Unable to encode social preview")
}

try png.write(to: root.appendingPathComponent("assets/not-there-yet-social-preview.png"))
