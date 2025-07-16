//
//  Learning.swift
//  MVVMExample
//
//  Created by Mehmet Emin Çetin on 15.07.2025.

// MVVM Mimarisi
// Model-View-ViewModel mimarisi, Kodun daha test edileiblir, daha okunabilir
// daha sürdürülbilir olmasını sağlar

// Model: Uygulamanın iş mantığı, veri yapıları, API'ler
// View: Kullanıcı arayüzü (UI)
// ViewModel: View ile Model arasındaki bağ, UI mantığı burada


// 1-Model
// Model katmanı genellikle struct veya class şeklinde tanımlanır ve veriler
// temsil eder.

struct User: Codable {
    let id: Int
    let name: String
    let email: String
}

// 2-ViewModel
// Modelden verileri alır, işler ve View'a sunar. UI ile doğrudan ilişkisi yoktur.

import Foundation
import Combine

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    
    func fetchUsers() {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.users = [
                User(id: 1, name: "Ahmet", email: "ahmet@example.com"),
                User(id: 2, name: "Ayse", email: "ayse@example.com")
            ]
            self.isLoading = false
        }
    }
}

// 3-View
// Kullanıcı arayüzünü tanımlar ve ViewModel'e bağlanır.
import SwiftUI

struct UserListView: View {
    @StateObject var viewModel = UserViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Yükleniyor...")
            } else {
                List(viewModel.users, id: \.id) { user in
                    VStack(alignment: .leading) {
                        Text(user.name).font(.headline)
                        Text(user.email).font(.subheadline).foregroundStyle(.gray)
                    }
                }
            }
        }
    }
}




