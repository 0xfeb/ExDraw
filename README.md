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

