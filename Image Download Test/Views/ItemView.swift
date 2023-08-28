//
//  ItemView.swift
//  Image Download Test
//
//  Created by Demir Dereli on 28.08.2023.
//

import SwiftUI

struct ItemView: View {
    @StateObject var vm: ItemViewModel
    var model: ImageModel
    
    init(model: ImageModel) {
        self.model = model
        self._vm = StateObject(wrappedValue: ItemViewModel(url: model.thumbnailURL))
    }
    
    var body: some View {
        HStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
            }
            else {
                ProgressView()
                    .padding()
                    .frame(width: 100, height: 100)
            }
            
            
            VStack(alignment: .leading){
                Text(model.title)
                    .font(.headline)
                Text(model.url)
                    .font(.body)
                    .foregroundColor(.accentColor)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(model: ImageModel.devInstance)
    }
}
