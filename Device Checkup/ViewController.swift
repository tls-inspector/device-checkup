import UIKit
import SafetyKit

class ViewController: UIViewController, SKScannerDelegate {
    var scanner: SKScanner!

    override func viewDidLoad() {
        super.viewDidLoad()
        scanner = SKScanner.withDelegate(self)
    }

    @IBAction func runTestsTap(_ sender: UIButton) {
        self.scanner.start()
    }

    func scannerFinishedAllTests() {
        print("Scanner finished all tests")
    }

    func test(_ test: SKTest, finishedWith result: SKTestResult) {
        print("Test \(test.testKey) finished!")
    }
}
