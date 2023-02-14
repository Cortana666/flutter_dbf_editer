import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  open var currentFile: String?

  override func awakeFromNib() {
    let flutterViewController = FlutterViewController.init()
    let windowFrame = self.frame

    let channel = FlutterMethodChannel(name: "myChannel", binaryMessenger: flutterViewController.engine.binaryMessenger)
    channel.setMethodCallHandler({
      (call: FlutterMethodCall, result: FlutterResult) -> Void in
      if (call.method == "getCurrentFile") {
        result(self.currentFile)
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
