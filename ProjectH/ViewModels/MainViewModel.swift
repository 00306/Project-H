//
//  MainViewModel.swift
//  ProjectH
//
//  Created by 송지혁 on 5/15/24.
//

import Combine
import Foundation
import Observation


@Observable
class MainViewModel {
    var hackathons: [Hackathon] = []
    private var cancellables = Set<AnyCancellable>()
    private var firestoreManager = FirestoreManager()
    
    func fetchHackathons() {
        firestoreManager.read()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { hackathons in
                self.hackathons = hackathons
            }
            .store(in: &cancellables)

    }
}
