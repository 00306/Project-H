//
//  FirestoreManager.swift
//  ProjectH
//
//  Created by 송지혁 on 5/14/24.
//


import Combine
import Firebase
import FirebaseFirestore
import FirebaseFirestoreCombineSwift

class FirestoreService {
    static let shared = FirestoreService()
    let db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    
    func create(user: UserInfo) -> AnyPublisher<Void, Error> {
        db.collection("Users")
            .document(user.uid)
            .setData(from: user)
            .eraseToAnyPublisher()
    }
    
    func readHackathons() -> AnyPublisher<[Hackathon], Error> {
        db.collection("Hackathons")
            .getDocuments()
            .map { snapshot in
                return snapshot.documents.compactMap { document in
                    var hackathon: Hackathon?
                    do {
                        hackathon = try document.data(as: Hackathon.self)
                        hackathon?.id = document.documentID
                    } catch {
                        print("Error decoding document: \(error)")
                    }
                    return hackathon

                }
            }
            .eraseToAnyPublisher()
    }
    
    func readBookmarkIDs(_ user: UserInfo) -> AnyPublisher<Set<String>, Error> {
        let uid = user.uid
        
        return db.collection("Users")
            .document(uid)
            .getDocument()
            .map { documentSnapshot in
                guard let bookmarks = documentSnapshot.data()?["bookmarks"] as? [String] else { return [] }
                return Set(bookmarks)
            }
            .eraseToAnyPublisher()
    }
    
    func readBookmarks(_ user: UserInfo) -> AnyPublisher<[Hackathon], Error> {
        let bookmarkList = Array(user.bookmarks)
        if bookmarkList.isEmpty {
            return Just([])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return db.collection("Hackathons")
            .whereField(FieldPath.documentID(), in: bookmarkList)
            .getDocuments()
            .map { querySnapshot in
                querySnapshot.documents.compactMap { document in
                    try? document.data(as: Hackathon.self)
                    
                }
            }
            .eraseToAnyPublisher()
    }
    
    func update(_ hackathon: Hackathon) -> AnyPublisher<Void, Error> {
        db.collection("Hackathons")
            .document(hackathon.id ?? "")
            .setData(from: hackathon, merge: true)
            .eraseToAnyPublisher()
    }
    
    func update(_ user: UserInfo) -> AnyPublisher<Void, Error> {
        db.collection("Users")
            .document(user.uid)
            .setData(from: user, merge: true)
            .eraseToAnyPublisher()
    }
    
    func updateBookmarks(user: UserInfo) -> AnyPublisher<Void, Error> {
        let bookmarkIDs = user.bookmarks.map { $0 }
        let updateData: [String: Any] = [
            "bookmarks": bookmarkIDs
        ]
        
        return db.collection("Users")
            .document(user.uid)
            .updateData(updateData)
            .eraseToAnyPublisher()
    }
}
