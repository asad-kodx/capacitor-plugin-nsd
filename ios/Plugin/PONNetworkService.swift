//
//  PONNetworkService.swift
//  NetworkPlugin
//
//  Created by Mac on 09/11/2023.
//

import Foundation

struct IPSocketAddress {
    var sa: sockaddr
    var ipv4: sockaddr_in
    var ipv6: sockaddr_in6
}

class PONNetworkService {
    var serviceName: String
    var printerCount: Int
    var isUntrustedCert: Bool
    var isSearchable: Bool
    var serviceType: Int
    var serviceID: String
    var serviceURL: String

    init(service: NetService) {
        
        self.serviceName = service.name
        self.printerCount = NSNotFound
        self.isUntrustedCert = false
        self.serviceType = 0
        self.serviceID = ""
        self.serviceURL = ""
        self.isSearchable = true

        let txtRecordData = service.txtRecordData()
        if let txtRecordData = txtRecordData, txtRecordData.count > 0 {
            let dictionary = NetService.dictionary(fromTXTRecord: txtRecordData)
            if let disc = copyString(fromTXTDictionary: dictionary, forKey: "disc") {
                self.isSearchable = (disc.isEmpty) ? true : Bool(disc) ?? true
            }
            if let type = copyString(fromTXTDictionary: dictionary, forKey: "type") {
                self.serviceType = type.isEmpty ? 0 : Int(type) ?? 0
            }
            if let serviceIDData = dictionary["serviceID"] {
                self.serviceID = String(data: serviceIDData, encoding: .utf8) ?? ""
            }

            if let serviceURL = dictionary["srvuri"] as? String, !serviceURL.isEmpty {
                self.serviceURL = serviceURL
            } else if self.serviceType == 2 {
                self.serviceURL = "https://www.printeron.net"
            } else {
                let host = ipFromNetService(service)
                let secure = Bool((dictionary["sec"] as? String) ?? "false") ?? false
                let portnum = service.port
                let port = secure ? (portnum == 443) ? "" : ":\(portnum)" : (portnum == 0 || portnum == 80) ? "" : ":\(portnum)"
                let schema = secure ? "https" : "http"
                var path = dictionary["path"] as? String
                if let sPath = path, !(path ?? "").hasPrefix("/") {
                    path = "/\(sPath)"
                }
                let user = dictionary["u"] as? String
                let password = dictionary["p"] as? String

                serviceURL = "\(schema)://\(user ?? "")\(password != nil ? ":" : "")\(password ?? "")\(user != nil || password != nil ? "@" : "")\(host)\(port)\(path ?? "")"
        }
        }
    }

    func copyString(fromTXTDictionary dictionary: [String: Data], forKey key: String) -> String? {
        if let data = dictionary[key] {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }

    func ipFromNetService(_ service: NetService) -> String? {
        var ipAddress: String?

        for data in service.addresses ?? [] {
            var storage = sockaddr_storage()
            (data as NSData).getBytes(&storage, length: MemoryLayout<sockaddr_storage>.size)

            if storage.ss_family == sa_family_t(AF_INET) {
                var addr4 = withUnsafePointer(to: &storage) {
                    $0.withMemoryRebound(to: sockaddr_in.self, capacity: 1) {
                        $0.pointee
                    }
                }
                ipAddress = String(cString: inet_ntoa(addr4.sin_addr))
            } else if storage.ss_family == sa_family_t(AF_INET6) {
                var addr6 = withUnsafePointer(to: &storage) {
                    $0.withMemoryRebound(to: sockaddr_in6.self, capacity: 1) {
                        $0.pointee
                    }
                }
                var buffer = [CChar](repeating: 0, count: Int(INET6_ADDRSTRLEN))
                if let result = inet_ntop(AF_INET6, &addr6.sin6_addr, &buffer, socklen_t(INET6_ADDRSTRLEN)) {
                    ipAddress = String(cString: result)
                }
            }

            if ipAddress != nil {
                break
            }
        }

        return ipAddress
    }
    
}
