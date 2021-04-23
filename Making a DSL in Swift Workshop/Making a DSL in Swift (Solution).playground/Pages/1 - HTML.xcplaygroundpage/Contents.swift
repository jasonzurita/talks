import Foundation
import WebKit.WKWebView
import PlaygroundSupport

/* Intro
 - HTML = Hypertext Markup Language
 - To learn more: https://www.w3schools.com/html/
 */

/* Resources
- Function builders: https://forums.swift.org/t/function-builders/25167
- An example Swift website using an HTML DSL: https://swift-aws-lambda-website.jasonzurita.com
*/

/////////////////////////////////
// PART 1/4 — Getting Started ///
/////////////////////////////////
/* Goals
 - Make a HTML DSL (let's walk through this together)
 - Transfer the below HTML into our DSL (**)
 - Define a render function that will print out the HTML
 - Use the render function to print out the DSL (**)
 */

// These are pulled out for multiple use
let rikoUrl = URL(string: "https://www.tryswift.co/assets/images/speakers/world/riko.png")!
let swiftString = "Announced in 2014, the Swift programming language has quickly become one of the fastest growing languages in history. Swift makes it easy to write software that is incredibly fast and safe by design. Our goals for Swift are ambitious: we want to make programming simple things easy, and difficult things possible."

// Example
let html = """
<html>
    <body>
        <h2>Welcome to Making a DSL in Swift!</h2>
        <img src="\(rikoUrl.absoluteString)" width="50" height="50"></img>
        <p style="color:blue;">\(swiftString)</p>
    </body>
</html>
"""

// Commented out in solving PART 1
//let webView = WKWebView(frame: .init(x: 0, y: 0, width: 400, height: 400))
//webView.loadHTMLString(html, baseURL: nil)
//PlaygroundPage.current.liveView = webView

enum HtmlNode {
    indirect case element(
        String,
        attrs: [(String, String)] = [],
        copy: String = "",
        [HtmlNode] = []
    )
}

let dsl: HtmlNode = .element("html", [
    .element("body", [
        .element("h2", copy: "Welcome to Making a DSL in Swift!"),
        .element("img", attrs: [
            ("src","\"\(rikoUrl.absoluteString)\""),
            ("width", "\"50\""), ("height", "\"50\"")
        ]),
        .element("p", copy: swiftString),
    ])
])

func render(_ node: HtmlNode) -> String {
    switch node {
    case let .element(el, attrs, copy, nested) where nested.isEmpty:
        let attributes = attrs.isEmpty ? "" : " \(attrs.map { "\($0.0)=\($0.1)" }.joined(separator: " "))"
        return """
        <\(el)\(attributes)>\(copy)</\(el)>
        """
    case let .element(el, attrs: attrs, _, nested):
        let attributes = attrs.isEmpty ? "" : " \(attrs.map { "\($0.0)=\($0.1)" }.joined(separator: " "))"
        return """
        <\(el)\(attributes)>
            \(nested.map { render($0) }.joined(separator: "\n"))
        </\(el)>
        """
    }
}

print(render(dsl))

// Commented out in solving PART 2
//let webView = WKWebView(frame: .init(x: 0, y: 0, width: 400, height: 400))
//webView.loadHTMLString(render(dsl), baseURL: nil)
//PlaygroundPage.current.liveView = webView


//////////////////////////////////
// PART 2/4 — Improving the DSL //
//////////////////////////////////
/* Goals
 - Bring the DSL closer to HTML syntax
   + html, body, h2, img, & p tags
 - Make the DSL safer
*/

func html(_ nested: HtmlNode...) -> HtmlNode {
    .element("html", nested)
}

func body(attrs: [(String, String)] = [],_ nested: HtmlNode...) -> HtmlNode {
    .element("body", attrs: attrs, nested)
}

func h2(attrs: [(String, String)] = [], title: String) -> HtmlNode {
    .element("h2", attrs: attrs, copy: title)
}

func img(src: URL, attrs: [(String, String)]) -> HtmlNode {
    .element("img", attrs: [("src", "\(src.absoluteString)")] + attrs)
}

func p(attrs: [(String, String)], copy: String) -> HtmlNode {
    .element("p", attrs: attrs, copy: copy)
}

func div(attrs: [(String, String)] = [], nested: HtmlNode...) -> HtmlNode {
    .element("div", attrs: attrs, nested)
}

// style attr added in completing PART 3
let dsl2: HtmlNode = html(
    body(
        h2(title: "Welcome to Making a DSL in Swift!"),
        img(src: rikoUrl, attrs: [
            ("width", "\"50\""),
            ("height", "\"50\"")
        ]),
        p(attrs: [("style", "\"color:blue;\"")], copy: swiftString)
    )
)

// Commented out in solving PART 3
//let webView = WKWebView(frame: .init(x: 0, y: 0, width: 400, height: 400))
//webView.loadHTMLString(render(dsl2), baseURL: nil)
//PlaygroundPage.current.liveView = webView


///////////////////////////
// PART 3/4 — Styling /////
///////////////////////////
/* Goal
 - Like the last part, clarify and enforce styling corectness using functions
   + width, height, & color
 */

func width(_ width: Int) -> (String, String) {
    ("width", "\"\(width)\"")
}

func height(_ height: Int) -> (String, String) {
    ("width", "\"\(height)\"")
}

enum Color: String {
    case blue, red, yellow, black
}

func color(_ color: Color) -> (String, String) {
    ("style", "\"color:\(color);\"")
}

let dsl3: HtmlNode = html(
    body(
        h2(title: "Welcome to Making a DSL in Swift!"),
        img(src: rikoUrl, attrs: [width(50), height(50)]),
        p(attrs: [color(.blue)], copy: swiftString)
    )
)

// Commented out in solving PART 4
//let webView = WKWebView(frame: .init(x: 0, y: 0, width: 400, height: 400))
//webView.loadHTMLString(render(dsl3), baseURL: nil)
//PlaygroundPage.current.liveView = webView


//////////////////////////////////
// PART 4/4 — Feel the power 💪 //
//////////////////////////////////
/* Goals
 - Implement higher order processing. Highlight a particular string in all `p` tags.
 - Try one on your own
*/

//<div class="name-bio-wrapper">
//<div class="name"><div class="content">Jason Zurita</div></div>
//<div class="bio"><div class="content">I like to make things</div></div>
//</div>

let mattPic = URL(string: "https://media-exp1.licdn.com/dms/image/C4D03AQGVpCGtAqVwIQ/profile-displayphoto-shrink_800_800/0/1607606225087?e=1622073600&v=beta&t=c7ZkloxCSjIgJuOPmXenRZlm3ZonVhCz219AbLT3j0k")!


let dsl4: HtmlNode = html(
    body(
        h2(title: "Matt Baron"),
        img(src: mattPic, attrs: [width(75), height(75)]),
        p(attrs: [color(.black)], copy: "BIO SITES MOBILE TEAM LEAD @ UNFOLD (LIKE THE THING YOU'RE LOOKING AT RIGHT NOW!)")
    )
)

func pHighlight(_ str: String, in node: HtmlNode) -> HtmlNode {
    switch node {
    case let .element(el, attrs, copy, _) where el == "p":
        let modifiedStr = copy.replacingOccurrences(of: str, with: "<mark>\(str)</mark>")
        return p(attrs: attrs, copy: modifiedStr)
    case let .element(el, attrs, copy, nested):
        let nestedPrime = nested.map { pHighlight(str, in: $0) }
        return .element(el, attrs: attrs, copy: copy, nestedPrime)
    }
}

func changeName(_ str: String, to toStr: String, in node: HtmlNode) -> HtmlNode {
    switch node {
    case let .element(el, _, _, _) where el == "h2":
        return h2(title: toStr)
    case let .element(el, attrs, copy, nested):
        let nestedPrime = nested.map { changeName(str, to: toStr, in: $0) }
        return .element(el, attrs: attrs, copy: copy, nestedPrime)
    }
}

// todo break the higher order functions up
let webView = WKWebView(frame: .init(x: 0, y: 0, width: 400, height: 400))
webView.loadHTMLString(render(changeName("Matt Baron", to: "Jason Zurita", in: pHighlight("SITES", in: dsl4))), baseURL: nil)
PlaygroundPage.current.liveView = webView
