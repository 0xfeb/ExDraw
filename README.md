# ExDraw
### CoreGraphics extra library. Add some features to make programming suitable.

### Install

* Use source code, download source and drag into your project. 

* Use cocoapods, write a line into your Podfile. 
`pod 'ExDraw'`

### Builder
* Functions

Create a CGRect structure
> `ex_rect(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) -> CGRect `

Create a CGPoint structure
> `ex_point(_ x:CGFloat, _ y:CGFloat) -> CGPoint`

Create a CGSize structure
> `ex_size(_ w:CGFloat, _ h:CGFloat) -> CGSize`

Get center point of two points
> `ex_center(point1:CGPoint, point2:CGPoint) -> CGPoint`

Get length of two points
> `ex_length(point1: CGPoint, point2: CGPoint) -> CGFloat`

Get angle of line linked by two points
> `ex_angle(point1: CGPoint, point2: CGPoint) -> CGFloat`

* Extensions - CGRect

Use center point and size to create a CGRect structure
> `init(center p:CGPoint, size:CGSize)`

Use corner point and size to create a CGRect structure
> `init(leftTop p:CGPoint, size:CGSize)`

> `init(rightTop p:CGPoint, size:CGSize)`

> `init(leftBottom p:CGPoint, size:CGSize)`

> `init(rightBottom p:CGPoint, size:CGSize)`

Use two points to create a CGRect structure
> `init(point1:CGPoint, point2:CGPoint)`


### Parts

* Extensions - CGRect

Parts of proporty
> `left:CGFloat` -- Get/Set

> `right:CGFloat` -- Get/Set

> `top:CGFloat` -- Get/Set

> `bottom:CGFloat` -- Get/Set

> `shortBorderLength:CGFloat` -- Get

> `longBorderLength:CGFloat` -- Get

> `hypotenuseLength:CGFloat` -- Get

Points of rect
> `center:CGPoint` -- Get/Set

> `leftTop:CGPoint` -- Get/Set

> `rightTop:CGPoint` -- Get/Set

> `leftBottom:CGPoint` -- Get/Set

> `rightBottom:CGPoint` -- Get/Set

> `topCenter:CGPoint` -- Get/Set

> `bottomCenter:CGPoint` -- Get/Set

> `leftCenter:CGPoint` -- Get/Set

> `rightCenter:CGPoint` -- Get/Set


### Transform

* Extensions - CGRect

Make a offseet moving or get moved rect
> `mutating func move(offset:(CGFloat, CGFloat))`

> `func moved(offset:(CGFloat, CGFloat)) -> CGRect`

Clip a rect with edge insets. Use number less than zero in edgeinsets to exclusion the rect.
> `mutating func clip(edge:UIEdgeInsets)`

> `func cliped(edge:UIEdgeInsets) -> CGRect`

Scale a rect or get scaled rect, there are two ways in parameters, about fixed size clip or rate size clip. 
> `mutating func scale(size:(CGFloat, CGFloat))`

> `mutating func scale(rate:(CGFloat, CGFloat))`

> `func scaled(size:(CGFloat, CGFloat)) -> CGRect`

> `func scaled(rate:(CGFloat, CGFloat)) -> CGRect`

Get relation rect inner or outter. 
> `var innerSqure : CGRect`

> `var outterSqure : CGRect`

> `var innerCycle : CGRect`

> `var outterCycle : CGRect`

Devide a rect into two rects. fixed or rate deviding. First item in result is the rect which neared edge, and the second far away from edge.
> `func devided(from edge:CGRectEdge, fix:CGFloat) -> (CGRect, CGRect)`

> `func devided(from edge:CGRectEdge, rate:CGFloat) -> (CGRect, CGRect)`

Resize rect or get a resized rect.
> `mutating func resize(fixCorner:RectCorner, size:CGSize)`

> `func resized(fixCorner:RectCorner, size:CGSize) -> CGRect`


### Grid

* Extensions - CGRect

> A structure to description about relationship between height and width. 

> `HeightWidthRate`

> A number to mark about height devide to width.
>> `heightDWidth` 

> Add extra number to plus the result of height multiply heightDWidth
>> `constant`

> Get width of height.
>> `func widthOf(height: CGFloat) -> CGFloat`

> Get height of width.
>> `func heightOf(width: CGFloat) -> CGFloat`

Build fixed grids' rect in a rect

> `func buildGrids(rowCount: Int, itemsInRow: Int,
                           edge: UIEdgeInsets = UIEdgeInsets.zero,
                           hSpace: CGFloat = 0, vSpace: CGFloat = 0) -> [CGRect]`

Build flow grids' rect in a rect

> `func buildHFlowGrids(rowCount: Int, hwRate: HeightWidthRate, itemsCount: Int,
                                edge: UIEdgeInsets = UIEdgeInsets.zero,
                                hSpace: CGFloat = 0, vSpace: CGFloat = 0) -> [CGRect]`

> `func buildVFlowGrids(itemsInRow: Int, hwRate: HeightWidthRate, itemsCount: Int,
                                edge: UIEdgeInsets = UIEdgeInsets.zero,
                                hSpace: CGFloat = 0, vSpace: CGFloat = 0) -> [CGRect]`
                                
Get a flow grid's rect in a rect

> `itemAtHFlowGrids(rowCount: Int, hwRate: HeightWidthRate, item: Int,
                                 edge: UIEdgeInsets = UIEdgeInsets.zero,
                                 hSpace: CGFloat = 0, vSpace: CGFloat = 0) -> CGRect`
                                                                

> `itemAtVFlowGrids(itemsInRow: Int, hwRate: HeightWidthRate, item: Int,
                                 edge: UIEdgeInsets = UIEdgeInsets.zero,
                                 hSpace: CGFloat = 0, vSpace: CGFloat = 0) -> CGRect`


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

### Path 

* Extension - CGPath

Generate path from text

> `static func from(text:String) -> CGPath`


Convert path to text

> `var text:String`

### Author
WangYuanou

2018-07-27
