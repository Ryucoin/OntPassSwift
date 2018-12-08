//
//  NeoController.swift
//  RyuHomebaseApp
//
//  Created by Ross Krasner on 10/23/18.
//  Copyright © 2018 Ross Krasner. All rights reserved.
//


import Foundation

class OntController: NSObject {
    static let shared = OntController()
    
    func walletLogin(for wif: String) -> Bool {
        
        return false
    }
    
    func createWallet() -> Bool {

        return false
    }
    
    
    func storeWIF(wif: String) -> Bool {
        let data = wif.data(using: String.Encoding.utf8)!
        let tag = "signup.ryucoin.com"
        let addquery: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                       kSecAttrService as String: tag,
                                       kSecValueData as String: data]
        let status = SecItemAdd(addquery as CFDictionary, nil)
        if status == errSecDuplicateItem {
            _ = SecItemDelete(addquery as CFDictionary)
            _ = SecItemAdd(addquery as CFDictionary, nil)
        } else {
            guard status == errSecSuccess  else {
                print("Failed to Store")
                return false
            }
        }
        print("Stored wif successfully")
        return true
    }
    
    
    func getWIF() -> String? {
        let tag = "signup.ryucoin.com"
        let getquery: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                       kSecAttrService as String: tag,
                                       kSecReturnData as String: true]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(getquery as CFDictionary, &item)
        guard status == errSecSuccess else {
            print("Error finding password")
            return nil
        }
        guard item != nil else {
            print("No item found")
            return nil
        }
        if let data = item as? Data {
            let wif = String(data: data, encoding: .utf8)!
            return wif
        } else {
            return nil
        }
    }

    func logUserOut() {

    }
}
