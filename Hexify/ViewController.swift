import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var HexInput: NSTextField!
    
    let hexSet = (Array(97...102) + Array(48...57)).map{Character(UnicodeScalar(UInt8($0)))}
    static func newInstance() -> ViewController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier("ViewController")
            
        guard let viewController = storyboard.instantiateController(withIdentifier: identifier) as? ViewController else {
            fatalError("Unable to instantiate ViewController in Main.storyboard")
        }
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        HexInput.action = #selector(self.updateFromHex)
        HexInput.focusRingType = .none
        HexInput.wantsLayer = true
        HexInput.layer?.borderColor = NSColor.purple.cgColor
        HexInput.layer?.borderWidth = 1
    }
    
    func substr(str: String, lb: Int, ub: Int) -> String {
        return String(str[str.index(str.startIndex, offsetBy: lb)...str.index(str.startIndex, offsetBy: ub)])
    }
    
    @objc func updateFromHex() {
        var hexcode = HexInput.stringValue.lowercased()
    
        if hexcode.starts(with: "#") {
            hexcode = substr(str: hexcode, lb: 1, ub: hexcode.count - 1)
        }
            
        if Array(hexcode).allSatisfy({hexSet.contains($0)}) && hexcode.count == 6 {
            let r = Double(Int(substr(str: hexcode, lb: 0, ub: 1), radix: 16)!)
            let g = Double(Int(substr(str: hexcode, lb: 2, ub: 3), radix: 16)!)
            let b = Double(Int(substr(str: hexcode, lb: 4, ub: 5), radix: 16)!)
            HexInput.layer?.borderColor = NSColor.purple.cgColor
            self.view.layer?.backgroundColor = NSColor.init(red: CGFloat(r / 255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: 1.0).cgColor
        } else {
            HexInput.layer?.borderColor = NSColor.red.cgColor
        }
        
        print(HexInput.stringValue)
    }

    override var representedObject: Any? {
        didSet {

        }
    }
    
    override func awakeFromNib() {
        if self.view.layer != nil {
            let r = Int.random(in: 0...255)
            let g = Int.random(in: 0...255)
            let b = Int.random(in: 0...255)
            
            HexInput.stringValue = "#\(String(r, radix: 16))\(String(g, radix: 16))\(String(b, radix: 16))"
            self.view.layer?.backgroundColor = NSColor(calibratedRed: CGFloat(Double(r)/255.0), green: CGFloat(Double(g)/255.0), blue: CGFloat(Double(b)/255.0), alpha: 1.0).cgColor
        }
    }
}

