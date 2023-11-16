import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(NSDPlugin)
public class NSDPlugin: CAPPlugin, NetServiceBrowserDelegate, NetServiceDelegate  {
    private let implementation = NSD()

    private var netServiceBrowser: NetServiceBrowser!
    private var services = [NetService]()
    
    public override func load() {
        self.services.removeAll()
        netServiceBrowser = NetServiceBrowser()
    }
    
    @objc func startFindNewtworkService(_ call: CAPPluginCall) {
        if let type = call.getString("type"), let domain = call.getString("domain") {
            netServiceBrowser.delegate = self
            netServiceBrowser.searchForServices(ofType: type, inDomain: domain)
        }
        call.resolve()
    }

      @objc func stopNetworkService(_ call: CAPPluginCall) {
        netServiceBrowser.stop()
        call.resolve()
    }
    
    @objc func getAllNetworkService(_ call: CAPPluginCall) {
        let discoveredServices = self.getDiscoveredServices()
        let allNetworkServices: [JSObject] = discoveredServices.map { (service) -> JSObject in
            print("Service Name: \(service.name)")
            print("Type: \(service.type)")
            return makeObject(PONNetworkService(service: service))
            
//            var txt: [String: Data]? = nil
//            
//            if let txtRecordData = service.txtRecordData() {
//                txt = NetService.dictionary(fromTXTRecord: txtRecordData) as [String: Data]
//            }
//            
//            return [
//                "hostname": service.hostName ?? "",
//                "port": service.port,
//                "name": service.name,
//                "txt": txt ?? [:]
//            ]
        }
        call.resolve(["services": allNetworkServices])
    }

    // MARK: - NetServiceBrowserDelegate

    public func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        services.append(service)
        if !moreComing {
            self.updateInterface()
        }
    }
    
    public func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool) {
        self.notifyListeners("onServiceRemoved", data: ["service": makeObject(PONNetworkService(service: service))])
    }
    
    public func netServiceDidResolveAddress(_ service: NetService) {
        let jsObject = makeObject(PONNetworkService(service: service))
        self.notifyListeners("onServiceResolved", data: jsObject)
        
    }
    
    public func netService(_ service: NetService, didNotResolve errorDict: [String : NSNumber]) {
        print("didn't resolve \(String(describing: errorDict))")
        self.notifyListeners("onServiceError", data: ["code": "didNotResolve", "error": String(describing: errorDict)])
    }
    
    public func netServiceBrowser(_ browser: NetServiceBrowser, didNotSearch errorDict: [String : NSNumber]) {
        self.notifyListeners("onServiceError", data: ["code": "didNotSearch", "error": String(describing: errorDict)])
    }
    
    public func netServiceBrowserDidStopSearch(_ browser: NetServiceBrowser) {
        self.notifyListeners("onDiscoveryStopped", data: nil)
        netServiceBrowser.delegate = nil
    }

    // Function to retrieve discovered services
    func getDiscoveredServices() -> [NetService] {
        return services
    }
    
    private func updateInterface() {
        for service in services {
            if service.port == -1 {
                service.delegate = self
                service.resolve(withTimeout: 10)
            }
        }
    }
    
    private func makeObject(_ service: PONNetworkService) -> JSObject {
        return [
            "serviceName": service.serviceName,
            "printerCount": service.printerCount,
            "isUntrustedCert": service.isUntrustedCert,
            "isSearchable": service.isSearchable,
            "serviceType": service.serviceType,
            "serviceID": service.serviceID,
            "serviceURL": service.serviceURL
        ]
    }

}
