import SashaCore

let sasha = Sasha()

do {
    try sasha.run()
}
catch {
    print("❌ An error occurred:\n\(error.localizedDescription)")
}
