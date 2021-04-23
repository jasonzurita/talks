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

print(html)

let webView = WKWebView(frame: .init(x: 0, y: 0, width: 400, height: 400))
webView.loadHTMLString(html, baseURL: nil)
PlaygroundPage.current.liveView = webView

// PART 1 Solution
// ...


//////////////////////////////////
// PART 2/4 — Improving the DSL //
//////////////////////////////////
/* Goals
 - Bring the DSL closer to HTML syntax
   + html, body, h2, img, & p tags
 - Make the DSL safer
 - Write new DSL using the updated syntax
 - Render the new DSL
*/

// PART 2 Solution
// ...


///////////////////////////
// PART 3/4 — Styling /////
///////////////////////////
/* Goal
 - Like the last part, clarify and enforce styling corectness using functions
   + width, height, & color
 - Write new DSL using the updated styling syntax
 - Render the new DSL
 */

// PART 3 Solution
// ...


//////////////////////////////////
// PART 4/4 — Feel the power 💪 //
//////////////////////////////////
/* Goals
 - Implement higher order processing function. Highlight a particular string in all `p` tags
 - Use the higher order processing function before rendering
 - Try one on your own!
*/

// PART 4 Solution
// ...
