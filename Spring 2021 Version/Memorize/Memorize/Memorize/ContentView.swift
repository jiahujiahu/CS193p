//
//  ContentView.swift
//  Memorize
//
//  Created by Jia Hu on 2023-08-30.
//

import SwiftUI

// This ContentView behaves like/conforms to a View.
// and this idea of building a structure that behaves like something,
// is the fundamental underpinning of the functional programming methodology in Swift
// We learned that Swift also does obhect-oriented programming methology
// But at the UI portion is all functional programming.
//
// View is a rectangular are on screen.
// It can draw.
// It can receive multi-touch events.
struct ContentView: View {
    // We'd let swift infer the type
    // Strings do not behave like an identifiable because two Strings that look exactly the same might be different Strings.
    var emojis = ["🚂", "🚑", "🚔", "🛳", "🛴", "🚕", "🚌", "🏎", "🛻", "🚚", "🚛", "🚜", "✈️", "🚀", "🛶", "🚍", "🚁", "⛵️", "🛸", "🚲", "🛵", "🏍", "🚒", "🚐", "🚎", "🚙"] // 26 vehicles
    @State var emojiCount = 4
    // So the body of our View is some other View
    // Views like Legos, piece them together to build more powerful Lego, like a dinning room chair Lego,
    // and then piece that together with other more powerful Legos to make a dinning room Lego, and then
    // a house Lego and the neighborhood Lego, universe Lego.
    //
    // Now the value of this variable is calculated by executing this function
    // This function obviously has to return something that is a View, and
    // we know that the compiler is going to replace some View right here, with whatever the actual View
    // that returned from here is
    var body: some View {
        VStack { // these View combiners or Lego combiners as we called them are created like Lego bricks

            ScrollView {
                // HStack uses all the space it can, in both directions: height and width
                // LazyVGrid uses all the width horizontally for its columns, depending on the fixed and flexible
                // But vertically it's going to make the cards as small as possible, so it can fit as many as possible.
                //
                // A LasyVGrid is lazy about accessing the body vars of all of its Views
                // We only get the value of a body var in a LazyVGrid for Views that actually appear on screen, that scroll on screen.
                // So this LazyVGrid could scale to having thousands of cards, because in general, creating Views is really lightweight.
                // Usually a View is just a few vars, like isFaceUp and content in our CardView, but accessing a View's body is anouther story.
                // That's going to creat a whole bunch of other Views, and potentially cause some of their body vars to get accessed.
                // So there's a lot of infrastructure in SwiftUI to only access a View's body var when absolutely necessary.
                // this laziness we see in LazyVGrid. That's only a minor example of that.
                //
                // GridItems let you control the columns more
                // GirdItem(.fixed(200)) fixed at the 200 wide
                // GirdItem(.flexible()) flex to whatever space is available (default)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    // ForEach creates a View for each of the things in an Array
                    // if you want to do a ForEach, things in array must behave like/conforms to an identifiable
                    // what?
                    // any kind of sturct can be an identifiable, but it has to have a var called id,
                    // which uniquely identifies it
                    // why?
                    // Because it's going to create a View for each of them
                    // and if, for example this array right here should be reordered,
                    // or new things added to it or things removed from it, etc.,
                    // it needs to know which things changed in the array,
                    // and then adjust the views accordingly.
                    // So it needs to be able to uniquely identify everything in the Array
                    // to match up the View that it's going to create for them.
                    //
                    // id: \.self
                    // forces the ForEach to think that each of the Strings was itself identifiable
                    // And then we made sure to never put the same String in our array twice
                    // (So that was a bit of cheese)
                    // Yeah, just use the string itself as the unique identifier,
                    // even though it's not actually unique, do it anyway.
                    // All structures have this var on themselves called self, which means the sturct it self.
                    // Oh oh, you see when I tap on the train, it's using the same View for both of these,
                    // beacsue, again, the ForEach, can't tell these apart.
                    // So when it sees the train, it uses the CardView it's already made for a train over there
                    //
                    // [0..<6] zero up-to but not including the number six, just pick the first six
                    // [0...6] zero up-to and including the number six, which would be seven items over
                    ForEach(emojis[0..<emojiCount], id: \.self, content: { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit) // 2 wide : 3 high
                    })
                }
            }
            .foregroundColor(.red)
            // Space(minLength: 20) enforce some minLength of that Spacer
            // But a lot of times you want standard default spacing, because again, it can be device dependent, different on an Apple Watch than it is on iOS.
            Spacer()
            HStack {
                remove
                Spacer() // a Spacer is always going to grab as much as space as it can
                add
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }

    var remove: some View {
        // this blue is kind of standard control blue in the UI (default)
        // when users see this blue, they think
        // "Oh, I can probably touch on that."
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
            VStack {
                Image(systemName: "minus.circle")
            }
        }
    }
    var add: some View {
        Button {
            // emojis.count is just a var in Array that says how manys things are in that Array
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: {
            VStack {
                Image(systemName: "plus.circle") // https://developer.apple.com/sf-symbols/
            }
        }
    }
}

// all views in swiftui is immutable, cannot be modified
//
// how does my ui ever change then?
// your entire ui is being constantly rebuilt, happening very efficiently
// new views are being created to reflect the changes in your gram logic and replacing old views
struct CardView: View {
    var content: String

    // there is no way to change this var even though we call it a var once it's initilized
    // either by the creator up there or by using this default value, it cannot be changed
    //
    // @State turn this variable instead of really being a Boolean, it's actually a pointer
    // to some boolean somewhere else, somewhere is momory, and that's where the value can change
    // but this pointer does not change. it's always pointing to that same little space over there
    //
    // we're not going to @State very much, it's mostly just for temporary state
    // things that are like, I'm in the middle of a drag or a pinch multi-touch,
    // and I want to keep some state as the drag's going on,
    // and then when the drag's over, then I don't care about the state anymore
    // because my logic will have changed persumably
    @State var isFaceUp: Bool = true

    var body: some View {
        // a list of Views we called a bag of Lego View
        // and it's made with kind of a special functional syntax called ViewBuilder
        // ViewBuilders allow us to just list our Views
        ZStack { // stacking them towards us
            // we do local variables to clean our code
            let shape = RoundedRectangle(cornerRadius: 20)
            // we do if then's to determine which Views get into our bag of Lego
            if isFaceUp {
                // we've got these three Views listed
                shape.fill().foregroundColor(.white)
                // stroke
                // draws a fat line around right on top of the  border.
                // So some of the line is spilling onto the inside of the shape, and some is spilling on the outside.
                // strokeBorder
                // strokes just like storke does, but it strokes the border, so stroking on the inside
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}












struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView()
//            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
            .previewInterfaceOrientation(.portrait)
    }
}
