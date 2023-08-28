//
//  MainView.swift
//  Image Download Test
//
//  Created by Demir Dereli on 28.08.2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var vm = MainViewModel()
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(vm.imageModels) {model in
                    ItemView(model: model)
                }
            }
            .navigationTitle("Images")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
