import Flutter
import UIKit
import SystemConfiguration.CaptiveNetwork
import NetworkExtension

public class FlutterIpPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_ip_plugin", binaryMessenger: registrar.messenger())
        let instance = FlutterIpPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getIp":
            if let args = call.arguments as? [String: Any],
               let useWifi = args["useWifi"] as? Bool {
                getIpAddress(useWifi: useWifi, result: result)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENTS",
                                  message: "Arguments are invalid",
                                  details: nil))
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func getIpAddress(useWifi: Bool, result: @escaping FlutterResult) {
        var address: String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else {
            result("No IP found")
            return
        }
        defer { freeifaddrs(ifaddr) }
        
        var ptr = ifaddr
        while ptr != nil {
            defer { ptr = ptr?.pointee.ifa_next }
            
            let interface = ptr?.pointee
            let addrFamily = interface?.ifa_addr.pointee.sa_family
            
            if addrFamily == UInt8(AF_INET) {
                let name = String(cString: (interface?.ifa_name)!)
                
                if useWifi && name == "en0" || !useWifi && name == "pdp_ip0" {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface?.ifa_addr,
                              socklen_t((interface?.ifa_addr.pointee.sa_len)!),
                              &hostname,
                              socklen_t(hostname.count),
                              nil,
                              0,
                              NI_NUMERICHOST)
                    address = String(cString: hostname)
                    break
                }
            }
        }
        
        result(address ?? "No IP found")
    }
} 