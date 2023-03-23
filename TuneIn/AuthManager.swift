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
    
    private let auth = Auth.auth()
    
    private var verificationID: String?
    
    /*
     /if there is a user with the given phone number then returns false
     func checkPhoneDoesntExists(phoneNum: String, completion: @escaping (Bool) -> Void) {
     */
    
    //if mode = 1 then it is sign up, and call the check phone number function, if it is 2 then don't call it 
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
}
