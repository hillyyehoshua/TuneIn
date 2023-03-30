//
//  AuthManager.swift
//  TuneIn
//
//  Created by Izzy Hood on 3/20/23.
//


import FirebaseAuth
import Foundation

class AuthManager {
    
    static let shared = AuthManager()
    
    let auth = Auth.auth()
    
    private var verificationID: String?
    
    private var authStateDidChangeHandle: AuthStateDidChangeListenerHandle?

    init() {
        setupAuthStateDidChange()
    }
    
    // set up listener
    private func setupAuthStateDidChange() {
        authStateDidChangeHandle = auth.addStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in, you can update your UI or do other tasks
                print("User is signed in with uid: \(user.uid)")
            } else {
                // User is signed out
                print("User is signed out")
            }
        }
    }
    
    public func startAuth(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        
        print("beginning of auth function")
        
        auth.settings?.isAppVerificationDisabledForTesting = true
            
        print("startAuth called with phoneNumber: \(phoneNumber)")
        
        let provider = PhoneAuthProvider.provider()
        print(provider)
        print("Provider() called")
        
        provider.verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            
            print("PhoneAuthProvider.provider().verifyPhoneNumber closure called")

            if let error = error {
            print("Error with phone verification in startAuth: \(error.localizedDescription)")
            completion(false)
            return
            }
            
            if verificationID == nil {
                print("Verification ID is still nil")
                completion(false)
                return
            }
//
//
//            guard let verificationID = verificationID else {
//                print("Error with phone verification in startAuth: verification ID is nil")
//                completion(false)
//                return
//            }
            
            self.verificationID = verificationID
            print("Success with phone verification in startAuth. Verification ID: \(String(describing: verificationID))")
            completion(true)
            
        }
        
        print("PhoneAuthProvider.provider().verifyPhoneNumber called with phoneNumber: \(phoneNumber)")
    }
    
    

    
    public func verifyCode(smsCode: String, completion: @escaping (Bool) -> Void) {
        
        print("The SMS code: \(smsCode)")
        
        guard let verificationID = verificationID else {
            print("VerificationID was nil")
            completion(false)
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID, verificationCode: smsCode
        )
        
        auth.signIn(with: credential) { result, error in
            guard result != nil, error == nil else {
                print("Sign in was unsuccessful")
                completion(false)
                return
            }
            print("Sign in successful")
            completion(true)
        }
    }
    
    public func signOut() {
        do {
            try auth.signOut()
            print("User has been successfully signed out!!!!!!! Yas")
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    // Remove the listener when the object is deallocated
    deinit {
        if let handle = authStateDidChangeHandle {
            auth.removeStateDidChangeListener(handle)
        }
    }

}
