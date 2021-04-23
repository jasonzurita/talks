// swiftlint:disable switch_case_alignment
func f1() {
    if true {
        if true {
            if false {}
        }
    }
    if false {}
    // swiftlint:disable identifier_name
    let i = 0
    // swiftlint:enable identifier_name
    switch i {
        case 1: break
        case 2: break
        case 3: break
        case 4: break
        default: break
    }
    for _ in 1...5 {
        guard true else {
            return
        }
    }
}


[Int]().count == 0
