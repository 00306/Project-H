//
//  FirestoreManager.swift
//  ProjectH
//
//  Created by 송지혁 on 5/14/24.
//


import Combine
import FirebaseFirestore
import FirebaseFirestoreCombineSwift

class FirestoreManager {
    static let shared = FirestoreManager()
    let db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    
    func create(user: UserInfo) -> AnyPublisher<Void, Error> {
        db.collection("Users")
            .document(user.uid)
            .setData(from: user)
            .eraseToAnyPublisher()
    }
    
    func read() -> AnyPublisher<[Hackathon], Error> {
        db.collection("Hackathons")
            .getDocuments()
            .map { snapshot in
                snapshot.documents.compactMap { document in
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
}
