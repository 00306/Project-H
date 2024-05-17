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
    let db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    
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
}
