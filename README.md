# ExDraw
### CoreGraphics extra library. Add some features to make programming suitable.

### Install

* Use source code, download source and drag into your project. 

* Use cocoapods, write a line into your Podfile. 
`pod 'ExDraw'`

### Direction

* Enum -- ExDirection

Get a direction arrow in a squre.

Four border in squre.
> `toTop`

> `toRight`

> `toBottom`

> `toLeft`

Four corner in squre.
> `toTopRight`

> `toTopLeft`

> `toBottomRight`

> `toBottomLeft`

Get opsite direction of current direction.

> `opsite: ExDirection`

Get pixel point of marked by direction in rectangle.

> `func point(of rect: CGRect) -> CGPoint`

### Gradient

* Extension -- CGGradient

Get a gradient of two colors

> `static func dual(_ color0: UIColor, _ color1: UIColor) -> CGGradient? `

Get a gradient of many colors ( more than or equal to two )

> `static func multi(colorList: [UIColor]) -> CGGradient?`

Fill gradient in path, setup linear direction or nil for cycle mode.

> `func fill(inPath path: UIBezierPath, direction: ExDirection = .toBottom)`

Get an image object of gradient, setup linear direction or nil for cycle mode.

> `func image(size: CGSize, direction: ExDirection? = .toRight) -> UIImage`

### Context

* Extension -- CGContext

Get current context

> `static var current: CGContext?`

Flip origin of context canvas

> `func flipV(height: CGFloat)`


### String

* Extension -- String

Compute size of string

> `func size(attribute: ExAttributes) -> CGSize`

> `func size(font: UIFont) -> CGSize`

> `func size(fitSize: CGSize, attribute: ExAttributes) -> CGSize`

> `func size(fitSize: CGSize, font: UIFont, wordwarp: NSLineBreakMode, kern: CGFloat? = nil) -> CGSize`

Generate an image of text

> `func image(canvasSize: CGSize, textFrame: CGRect, attribute: ExAttributes) -> UIImage`


### AttributedString

* Class -- ExAttributes

Type of line width of strike throgh or underline

> ```
enum LineWidth: Int {
    case none = 0x00
    case single = 0x01
    case thick = 0x02
    case double = 0x09
}
```

Type of line style of strike throgh or underline

> ```
enum LineStyle: Int {
    case solid = 0x000
    case dot = 0x0100
    case dash = 0x0200
    case dashDot = 0x0300
    case dashDotDot = 0x0400
}
```

Properties of string attributes

> `var font:UIFont?`

> `var textColor:UIColor?`

> `var backColor:UIColor?`

> `var ligature:Bool?`

> `var kern:CGFloat?`

> `var strikethrough:(LineWidth, LineStyle, UIColor)?`

> `var underline:(LineWidth, LineStyle, UIColor)?`

> `var textStroke:(CGFloat, UIColor)?`

> `var shadow:NSShadow?`

> `var attachment:NSTextAttachment?`

> `var baseline:CGFloat?`

> `var expansion:CGFloat?`

> `var link:URL?`

> `var obliqueness:CGFloat?`

> `var vertical:Bool?`

> `var alignment:NSTextAlignment?`

> `var firstLineHeadIndent:CGFloat?`

> `var headIndent:CGFloat?`

> `var tailIndent:CGFloat?`

> `var lineBreakMode:NSLineBreakMode?`

> `var maximumLineHeight:CGFloat?`

> `var minimumLineHeight:CGFloat?`

> `var lineSpacing:CGFloat?`

> `var paragraphSpacing:CGFloat?`

> `var paragraphSpacingBefore:CGFloat?`

> `var baseWritingDirection:NSWritingDirection?`

> `var lineHeightMultiple:CGFloat?`

> `var defaultTabInterval:CGFloat?`

Default initial

> `init()`

Initial by image

> `init(image: UIImage, size: CGSize?)`

Get dictionary of attributes

> `var dict: [NSAttributedString.Key: AnyObject]`

Combine two attribute objects as one

> `func combine(_ attr: ExAttributes) -> ExAttributes`

> `static func + (attr0: ExAttributes, attr1: ExAttributes) -> ExAttributes`

> `static func += (attr0: inout ExAttributes, attr1: ExAttributes)`

If there is an image attachment in attribute, get the one

> `var imageString : NSAttributedString?`

* Extension -- NSAttributedString

Initial of string and attributes

> `init(text: String, attribute: ExAttributes)`

> `init(text: String, font: UIFont, color: UIColor, backColor: UIColor? = nil)`

Combine two attributed string as one

> `static func + (s0: NSAttributedString, s1: NSAttributedString) -> NSAttributedString`

> `static func += (s0:inout NSAttributedString, s1:NSAttributedString)`

* Extension -- UIImage

Get attributed string of this image

> `func attributeString(size: CGSize? = nil) -> NSAttributedString?`

* Extension -- String

Get attributed string of this image

> `func attributeString(_ attribute: ExAttributes) -> NSAttributedString`

* Functions

Get attributed string of HTML string

> `func ex_html(text: String) -> NSAttributedString?`

Get attributed string of rtf file

> `func ex_rtf(fileName: String) -> NSAttributedString?`

Get attributed string of rtfd file

> `func ex_rtfd(filename: String) -> NSAttributedString?`

### TextFrame

* Extension -- CTFrame

Draw ctframe in context

> `draw(inContext:CGContext)`

Generate ctframe by string

> `static func create(byText text:NSAttributedString, point:CGPoint) -> CTFrame`

* Extension -- CTFramesetter

Generate ctframe setter by string

> `static func create(byText text:NSAttributedString) -> CTFramesetter`

Suggest frame size of ctframe setter

> `func suggestSize(_ range:NSRange, size:CGSize) -> (NSRange, CGSize)`

Suggest pages of ctframe setter

> `func suggestPages(_ size:CGSize) -> [(NSRange, CGSize)]`

Suggest frames of ctframe setter

> `func suggestFrames(_ size:CGSize) -> [CTFrame]`

> `func suggestRangerAndFrames(_ size:CGSize) -> [(NSRange, CTFrame)]`

Get frame in line of ctframe setter

> `func lineFrame(charCount:Int, rect:CGRect) -> CTFrame`

### Author
WangYuanou

2018-07-27
