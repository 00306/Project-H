//
//  MainViewModel.swift
//  ProjectH
//
//  Created by 송지혁 on 5/15/24.
//

import Combine
import Foundation
import Observation


class MainViewModel: ObservableObject {
    @Published var hackathons: [Hackathon] = []
    @Published var searchText = ""
    @Published var searchedResult: [Hackathon] = []
    
    private var cancellables = Set<AnyCancellable>()
    private var firestoreService = FirestoreService()
    
    init() {
        $hackathons
            .sink { hackathons in
                self.searchedResult = hackathons
            }
            .store(in: &cancellables)
        
        $searchText
            .sink { completion in
                
            } receiveValue: { searchText in
                if searchText.isEmpty {
                    self.searchedResult = self.hackathons
                } else {
                    self.searchedResult = self.hackathons.filter { $0.name.contains(searchText) }
                }
            }
            .store(in: &cancellables)
        

    }
    
    func fetchHackathons() {
        firestoreService.readHackathons()
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
                print("Success", hackathons)
            }
            .store(in: &cancellables)
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
    
    func isExistInBookmark(hackathon: Hackathon, bookmarks: [Hackathon]) -> Bool {
        bookmarks.contains(hackathon)
    }
}
