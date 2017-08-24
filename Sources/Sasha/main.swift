//import SashaCore

let sasha = Sasha()

do {
    try sasha.run()
}
catch {
    print("Whoops! An error occurred: \(error)")
}
