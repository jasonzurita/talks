footer: Jason Zurita, @jasonalexzurita
slidenumbers: true

<!-- Deckset presentation -->

# 👋
## Linting & Formatting

---

## Goals
- Better understand "the why" and the differences between linting and formatting
- How to lint and format & what tools to use
- Different workflows
  + command-line
  + Xcode integration
  + CI/CD

---

## What is linting and formatting?

^
- Generally speaking: Automated styling and analysis of code
- There are tools that will do this for you

---

## Why lint/format your code?

^
- Reduce bikesheding during code review
- Helps flag code smells
- Code consistency, so you are freed up to focus on the more important problems

---

## Linting vs Formatting

^
Although there is overlap between the two, their primary functions are different

---

## Linting
- Deeper analysis of your code (e.g., [cyclomatic complexity](https://en.wikipedia.org/wiki/Cyclomatic_complexity), [file length](https://realm.github.io/SwiftLint/file_length.html))
- Can be automatically run (Xcode & in CI/CD systems)
- Fixes typically require human intervention
- Most popular tool: [SwiftLint](https://github.com/realm/SwiftLint)

^
Linting: command should act like a dryer machine lint trap

---

## Formatting
- Mainly focused on code style and format (e.g., spaces, wrapping brackets, etc.)
- Can be automatically run (Xcode & in CI/CD systems)
- Applying fixes can be done automatically (recommended)
- Most popular tool: [SwiftFormat](https://github.com/apple/swift-format)

---

## Let’s play with some tools (overview)
```swift
let tools = [
  [SwiftLint](https://github.com/realm/SwiftLint),
  [SwiftFormat](https://github.com/apple/swift-format),
]

tools.forEach {
  /*
    - install $0
    - Try $0 out via the (e.g., command-line)
    - Config $0, aka customizing the behavior (yml files)
    - How to integrate $0 into your Xcode project & local workflow
    - How to automate & add $0 to a CI/CD system
    - if $0 == "SwiftLint" {
        Stretch goal, look at setting up [Danger](https://danger.systems)
        in a continuous integration (CI)
      }
    */
}
```

^
Although SwiftLint and SwiftFormat are the more popular ones, there are others out there. For example, there is a (more or less) work in progress one by [Apple for code formatting](https://github.com/apple/swift-format).


