//
//  HackathonDetailView.swift
//  ProjectH
//
//  Created by 송지혁 on 5/17/24.
//

import SwiftUI

struct HackathonDetailView: View {
    @StateObject var hackathonDetailViewModel: HackathonDetailViewModel
    
    
    var body: some View {
        VStack {
            Text("hackathonDetailView")
        }
        .onAppear {
            hackathonDetailViewModel.checkAndIncrementHits()
        }
    }
}
