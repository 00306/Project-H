//
//  HackathonDetailViewModel.swift
//  ProjectH
//
//  Created by 송지혁 on 6/28/24.
//

import Combine
import Foundation
import SwiftUI

class HackathonDetailViewModel: ObservableObject {
    @Published var hackathon: Hackathon
    private let userDefaults = UserDefaults.standard
    private let cooldownPeriod: TimeInterval = 3600
    private let firestoreService: FirestoreService
    private var cancellables = Set<AnyCancellable>()
    
    init(hackathon: Hackathon, firestoreService: FirestoreService = FirestoreService.shared) {
        self.hackathon = hackathon
        self.firestoreService = firestoreService
    }
    
    func checkAndIncrementHits() {
        let lastViewedKey = "lastViewed_\(hackathon.id ?? "")"
        let currentTime = Date().timeIntervalSince1970

        if let lastViewedTime = userDefaults.double(forKey: lastViewedKey) as Double?, currentTime - lastViewedTime < cooldownPeriod {
            return
        } else {
            userDefaults.set(currentTime, forKey: lastViewedKey)
            incrementHits()
            updateHackathon(hackathon)
        }
    }
    
    func incrementHits() {
        hackathon.hits += 1
    }
    
    func updateHackathon(_ hackathon: Hackathon) {
        firestoreService.update(hackathon)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Update successful")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancellables)
    }
}
