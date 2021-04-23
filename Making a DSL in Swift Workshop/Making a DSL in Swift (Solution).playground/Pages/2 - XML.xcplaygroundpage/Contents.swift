import Foundation
import PlaygroundSupport

/* Intro
 - XML = Extensible markup language
 - Created to be human and machine readable
 - Used to encapsulate and transfer data
 - No presnetation information built in
 - To learn more: https://www.w3schools.com/xml/

 - Structure
   + _root_ element
   + Elements may have children
   + Elements may have attributes
   + Elements may have associated content
   + Tags need to be bookmatched (e.g., <tag1><tag2><tag1><tag2>)
   + Tags are case sensitive. Opening and closing tags must be the same
   + Attributes are optinal and values must be in quotes (e.g., meal="1")
   + At most, one attribute per element

   e.g.,
   <root>
     <child attribute="value">
       <subchild>.....</subchild>
     </child>
   </root>
 */

//////////////////////////////////
// PART 1/3 — Getting Started ////
//////////////////////////////////
/* Goals
- Make a XML DSL
  + hint: think about what we did for the HTML DSL
  + hint: consider breaking the implementation into a root and elements
- Transfer the below XML to our DSL (**)
- Define a render function(s) that will print out the XML
- Use the render function to print out the DSL (**)
*/

// Example
let xml = """
<groceries>
    <apple>7</apple>
    <pasta>
        <pene>1</pene>
    </pasta>
    <avacado meal="1">3</avacado>
    <bread meal="1">1</bread>
</groceries>
"""

// Added in solving PART 2
protocol XMLTag {}
enum Plist: XMLTag {}
enum General: XMLTag {}
// Added in solving PART 2

// PART 1 Solution

// Note: the `<A: XMLTag>`'s were added in solving PART 2
enum XML<A: XMLTag> {
    case root(String, [XMLElement<A>])
}

// Note: the `<A: XMLTag>`'s were added in solving PART 2
enum XMLElement<A: XMLTag> {
    indirect case element(
        String,
        attr: (String, String) = ("", ""),
        content: String = "",
        [XMLElement] = []
    )
}

let dsl: XML<General> = .root("groceries", [
    .element("apple",content: "7"),
    .element("pasta", [
        .element("pene", content: "1")
    ]),
    .element("avacado", attr: ("meal","1"), content: "3"),
    .element("bread", attr: ("meal","1"), content: "1"),
])

// Moved into an extension in solving PART 2
extension XML {
    func render() -> String {
        switch self {
        case let .root(tag, children):
            return """
            <\(tag)>
                \(indented: children.map { $0.render() }.joined(separator: "\n"))
            </\(tag)>
            """
        }
    }
}

// Moved into an extension in solving PART 2
extension XMLElement {
    func render() -> String {
        switch self {
        case let .element(tag, attr, content, children) where children.isEmpty:
            let attrString = attr.0.isEmpty ? "" : " \(attr.0)=\"\(attr.1)\""
            return """
            <\(tag)\(attrString)>\(content)</\(tag)>
            """
        case let .element(tag, attr, _, children):
            let attrString = attr.0.isEmpty ? "" : " \(attr.0)=\"\(attr.1)\""
            return """
            <\(tag)\(attrString)>
                \(indented: children.map { $0.render() }.joined(separator: "\n"))
            </\(tag)>
            """
        }
    }
}

print(dsl.render())

/////////////////////////
// PART 2/3 — PLIST /////
/////////////////////////

/* Background
 - Apple's Documentation: https://tinyurl.com/yc4jdnur
   + XML based
 - Why might we want to use a PLIST?
   + Store data, configuration, metadata, etc.
   + Most familiar PLIST will likely be the `Info.plist`
 - Structure
   + The root is almost always a `dict`
   + Children can be: array, dict, string, data, date, integer, floating point, boolean
 */

/* Goal
 - Specialize the above XML to create a PLIST DSL
   + Hint: Phantom types to the rescue
*/

// Example
let plist = """
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>en</string>
    <key>UISupportedInterfaceOrientations</key>
    <array>
        <string>UIInterfaceOrientationPortrait</string>
        <string>UIInterfaceOrientationLandscapeLeft</string>
    </array>
</dict>
</plist>
"""

// PART 2 Solution

func plist(_ children: [XMLElement<Plist>]) -> XML<Plist> {
    .root("dict", children)
}

func kv(_ key: String, _ value: Int) -> [XMLElement<Plist>] {
    [
        .element("key", content: "\(key)"),
        .element("integer", content: "\(value)")
    ]
}

func kv(_ key: String, _ value: String) -> [XMLElement<Plist>] {
    [
        .element("key", content: "\(key)"),
        .element("string", content: "\(value)")
    ]
}

func array(_ key: String, _ children: XMLElement<Plist>...) -> [XMLElement<Plist>] {
    [
        .element("key", content: "\(key)"),
        .element("array", children),
    ]
}

let plistDsl = plist(
    kv("CFBundleDevelopmentRegion", "en") +
    array("UISupportedInterfaceOrientations",
        .element("string", content: "UIInterfaceOrientationPortrait"),
        .element("string", content: "UIInterfaceOrientationLandscapeLeft")
    )
)

print(plistDsl.render())

//////////////////////////////////
// PART 3/3 — Use (challenge) ////
//////////////////////////////////
/* Goal
 - Validation: Write a function(s) to `ensure` that a particular key is in the plist
*/

// PART 3 Challenge Solution
func ensure(_ keyStr: String, in plist: XML<Plist>) -> Bool {
    switch plist {
    case let .root(_, children):
        return children.reduce(false) { $0 || ensure(keyStr, in: $1) }
    }
}

func ensure(_ keyStr: String, in element: XMLElement<Plist>) -> Bool {
    switch element {
    case let .element(key,_, content, children) where key == "key":
        guard content != keyStr else { return true }
        return children.reduce(false) { $0 || ensure(keyStr, in: $1) }
    case .element:
        return false
    }
}

ensure("UISupportedInterfaceOrientations", in: plistDsl)
