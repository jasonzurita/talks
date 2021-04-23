import Foundation
import PlaygroundSupport

/* Intro
 - XML = Extensible Markup Language
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
 - Define a print function(s) that will print out the XML
 - Use the print function to print out the DSL (**)
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

print(xml)

// PART 1 Solution
// ...


/////////////////////////
// PART 2/3 — PLIST /////
/////////////////////////
/* Goal
 - Specialize the above XML to create a PLIST DSL
   + Hint: Phantom types to the rescue
*/

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

// Example
let plist = """
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>en</string>
    <key>LSRequiresIPhoneOS</key>
    <true/>
    <key>UISupportedInterfaceOrientations</key>
    <array>
        <string>UIInterfaceOrientationPortrait</string>
        <string>UIInterfaceOrientationLandscapeLeft</string>
    </array>
</dict>
</plist>
"""

// PART 2 Solution
// ...


//////////////////////////////////
// PART 3/3 — Use (challenge) ////
//////////////////////////////////
/* Goal
 - Validation: Write a function(s) to `ensure` that a particular key is in the plist
*/

// PART 3 Solution
// ...
