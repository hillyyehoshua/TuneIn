//
//  AuthManager.swift
//  TuneIn
//
//  Created by Izzy Hood on 3/20/23.
//


import Firebase
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
                print("[DEBUG] User is signed in with uid: \(user.uid)")
            } else {
                // User is signed out
                print("[DEBUG] User is signed out")
            }
        }
    }
    
    public func startAuth(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        
        print("[DEBUG] beginning of auth function")
        
        auth.settings?.isAppVerificationDisabledForTesting = true
            
        print("[DEBUG] startAuth called with phoneNumber: \(phoneNumber)")
        
        let provider = PhoneAuthProvider.provider()
        print(provider)
        print("[DEBUG] Provider() called")
        
        provider.verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            
            print("[DEBUG] PhoneAuthProvider.provider().verifyPhoneNumber closure called")

            if let error = error {
            print("[DEBUG] Error with phone verification in startAuth: \(error.localizedDescription)")
            completion(false)
            return
            }
            
            if verificationID == nil {
                print("[DEBUG] Verification ID is still nil")
                completion(false)
                return
            }
//
//
//            guard let verificationID = verificationID else {
//                print("[DEBUG] Error with phone verification in startAuth: verification ID is nil")
//                completion(false)
//                return
//            }
            
            self.verificationID = verificationID
            print("[DEBUG] Success with phone verification in startAuth. Verification ID: \(String(describing: verificationID))")
            completion(true)
            
        }
        
        print("[DEBUG] PhoneAuthProvider.provider().verifyPhoneNumber called with phoneNumber: \(phoneNumber)")
    }
    
    

    
    public func verifyCode(smsCode: String, completion: @escaping (Bool) -> Void) {
        
        print("[DEBUG] The SMS code: \(smsCode)")
        
        guard let verificationID = verificationID else {
            print("[DEBUG] VerificationID was nil")
            completion(false)
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID, verificationCode: smsCode
        )
        
        auth.signIn(with: credential) { result, error in
            guard result != nil, error == nil else {
                print("[DEBUG] Sign in was unsuccessful")
                completion(false)
                return
            }
            print("[DEBUG] Sign in successful")
            completion(true)
        }
    }
    
    func linkPhoneNumberAuthWithOriginalUid(completion: @escaping (Error?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(NSError(domain: "User is not logged in", code: 401))
            return
        }

        let newUid = user.uid
        guard let phoneNumber = user.phoneNumber else {
            completion(NSError(domain: "Phone number is not linked to user", code: 400))
            return
        }

        let db = Firestore.firestore()
        let usersCollectionRef = db.collection("Users")
        usersCollectionRef.whereField("phoneNumber", isEqualTo: phoneNumber).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(error)
                return
            }

            guard let querySnapshot = querySnapshot else {
                completion(NSError(domain: "Original UID not found for phone number", code: 404))
                return
            }

            guard let originalUid = querySnapshot.documents.first?.documentID else {
                completion(NSError(domain: "Original UID not found for phone number", code: 404))
                return
            }

            let phoneAuthProvider = PhoneAuthProvider.provider()
            let credential = phoneAuthProvider.credential(withVerificationID: "", verificationCode: "")
            Auth.auth().currentUser?.link(with: credential) { (result, error) in
                if let error = error {
                    completion(error)
                    return
                }

                let userRef = usersCollectionRef.document(originalUid)
                userRef.updateData(["uid": newUid]) { error in
                    completion(error)
                }
            }
        }
    }


    
    public func signOut() {
        do {
            try auth.signOut()
            print("[DEBUG] User has been successfully signed out!!!!!!! Yas")
        } catch let error {
            print("[DEBUG] Error signing out: \(error.localizedDescription)")
        }
    }
    
    // Remove the listener when the object is deallocated
    deinit {
        if let handle = authStateDidChangeHandle {
            auth.removeStateDidChangeListener(handle)
        }
    }

}
