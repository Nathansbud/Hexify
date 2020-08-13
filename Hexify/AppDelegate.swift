/*
Credits:
 - https://8thlight.com/blog/casey-brant/2019/05/21/macos-menu-bar-extras.html
 - https://fleetingpixels.com/blog/2020/6/15/how-to-create-a-mac-menu-bar-app-with-nspopover
 - https://stackoverflow.com/questions/29612628/nspopover-not-closing
 - https://stackoverflow.com/a/41787180/9414576
 - https://stackoverflow.com/a/27705205/9414576
 - https://stackoverflow.com/questions/18568054/change-border-color-of-nstextfield
*/
import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!
    var window: NSWindow!
    
    let popover = NSPopover()

    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

        statusBarItem.button?.title = "🌈"
        statusBarItem.button?.action = #selector(AppDelegate.togglePopover(_:))

        popover.contentViewController = ViewController.newInstance()
        popover.animates = false
        popover.behavior = .transient
    }
    
    func showPopover(sender: Any?) {
        if let button = self.statusBarItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            
            popover.contentViewController?.view.window?.makeKey()
        }
    }

    func closePopover(sender: Any?)  {
        popover.performClose(sender)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationWillResignActive(_ notification: Notification) {
        if popover.isShown {
            closePopover(sender: nil)
        }
    }

    @objc func togglePopover(_ sender: Any) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    @objc func convertColor() {
        print("summertime, and the living's easy")
    }
    
    
    
    
}
