import UIKit
import PlaygroundSupport

let circleBackgroundColor = UIColor(red: 0 / 255,
                                    green: 153 / 255,
                                    blue: 255 / 255,
                                    alpha: 1)

let borderColor = UIColor(red: 0 / 255,
                          green: 85 / 255,
                          blue: 204 / 255,
                          alpha: 1)


// MARK: Diamond operator
precedencegroup SingleTypeComposition {
    associativity: right
}

infix operator<>: SingleTypeComposition
func <> <A: AnyObject>(f: @escaping (A) -> Void, g: @escaping (A) -> Void) -> (A) -> Void {
    return { a in
        f(a)
        g(a)
    }
}


// MARK: UIView styles
func styleViewBackground(color: UIColor) -> (UIView) -> Void {
    return {
        $0.backgroundColor = color
    }
}

func styleViewBorder(color: UIColor, width: CGFloat) -> (UIView) -> Void {
    return {
        $0.layer.borderColor = color.cgColor
        $0.layer.borderWidth = width
    }
}

let styleViewCircleBase: (UIView) -> Void =
    styleViewBackground(color: circleBackgroundColor)
        <> {
            $0.layer.cornerRadius = $0.frame.width * 0.5
            $0.layer.masksToBounds = true
        }

let styleViewCircleBorder: (UIView) -> Void =
    styleViewCircleBase
        <> styleViewBorder(color: borderColor, width: 4)


// MARK: UILabel styles
let styleLabelBase: (UILabel) -> Void = {
    $0.textAlignment = .center
    $0.textColor = .white
    $0.numberOfLines = 0
}

let styleLabelCircle: (UILabel) -> Void =
    styleLabelBase
    <> styleViewCircleBorder

let styleLabelCircleCheckmark: (UILabel) -> Void =
    styleLabelCircle
        <> {
            $0.text = "✓"
        }


// MARK: Display
final class MyViewController: UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = UIColor(red: 248 / 255, green: 248 / 255, blue: 248 / 255, alpha: 1.0)

        let baseCircle = UIView(frame: CGRect(x: 160, y: 120, width: 60, height: 60))
        styleViewCircleBase(baseCircle)
        view.addSubview(baseCircle)

        let borderCircle = UIView(frame: CGRect(x: 160, y: 205, width: 60, height: 60))
        styleViewCircleBorder(borderCircle)
        view.addSubview(borderCircle)

        let circleLabel = UILabel(frame: CGRect(x: 160, y: 290, width: 60, height: 60))
        circleLabel.text = "jz"
        styleLabelCircle(circleLabel)
        view.addSubview(circleLabel)

        let circleCheckmark = UILabel(frame: CGRect(x: 160, y: 375, width: 60, height: 60))
        styleLabelCircleCheckmark(circleCheckmark)
        view.addSubview(circleCheckmark)

        self.view = view
    }
}

PlaygroundPage.current.liveView = MyViewController()
