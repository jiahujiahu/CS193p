//
//  ContentView.swift
//  Memorize
//
//  Created by Jia Hu on 2023-08-30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack { // stacking them towards us
            RoundedRectangle(cornerRadius: 20.0)
                .stroke(lineWidth: 3)
            Text("Hello, world")
        }
        .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
        .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)




    }
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
