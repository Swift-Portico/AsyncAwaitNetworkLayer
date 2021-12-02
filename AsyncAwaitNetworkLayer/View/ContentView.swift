//
//  ContentView.swift
//  AsyncAwaitNetworkLayer
//
//  Created by Pradeep's Macbook on 02/12/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = CharacterViewModel.init(service: CharacterService())
    
    var body: some View {
        NavigationView {
            switch vm.state {
            case .success(data: let data):
                List {
                    ForEach(data,id:\.id) { character in
                        Text(character.name)
                    }
                }
                .navigationBarTitle("Characters")
            case .loading:
                ProgressView()
            default:
                EmptyView()
            }
        }
        .task {
            await vm.getCharacters()
        }
        .alert("Error", isPresented: $vm.hasError, presenting: vm.state) { detail in
            Button("Retry") {
                async {
                    await vm.getCharacters()
                }
            }
        } message: { detail in
            if case let .error(error) = detail {
                Text(error.localizedDescription)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
