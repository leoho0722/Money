//
//  LocalAuthenticationViewModel.swift
//  
//
//  Created by Leo Ho on 2023/4/8.
//

import SwiftUI
import LocalAuthentication

class LocalAuthenticationViewModel: ObservableObject {
    
    @Published var isAppLocked: Bool = false
    
    @Published var deviceSupportBiometryType: LABiometryType = .none
    
    func authenicate(policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics,
                     reason: String) async -> Bool {
        let context = LAContext()
        var error: NSError?
        guard context.canEvaluatePolicy(policy, error: &error) else {
            return false
        }
        do {
            return try await context.evaluatePolicy(policy, localizedReason: reason)
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func getBiometryType(policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics) {
        let context = LAContext()
        var error: NSError?
        guard context.canEvaluatePolicy(policy, error: &error) else {
            return
        }
        switch context.biometryType {
        case .none:
            self.deviceSupportBiometryType = .none
        case .touchID:
            self.deviceSupportBiometryType = .touchID
        case .faceID:
            self.deviceSupportBiometryType = .faceID
        @unknown default:
            self.deviceSupportBiometryType = .none
        }
    }
}
