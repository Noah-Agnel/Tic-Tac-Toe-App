import SwiftUI

struct ContentView: View {
    @State private var showingFullScreen = false
    var body: some View {
        ZStack {
            VStack {
                Image("grid")
                    .resizable()
                    .frame(width: 250.0, height: 250)
                
                Button("PLAY") {
                    showingFullScreen = true
                }
                .font(.largeTitle.bold())
                .frame(width: /*@START_MENU_TOKEN@*/150.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/75.0/*@END_MENU_TOKEN@*/)
                .foregroundColor(.black)
                .padding()
                .background(Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 15))
                .fullScreenCover(isPresented: $showingFullScreen) {
                    SecondContentView()
                }
            }
        }
    }
}


struct SecondContentView: View {
    @State private var gameover = false
    @State private var backhome = false
    @State private var computer = false
    @State private var tie = true
    @State private var x: [Bool] = Array(repeating: false, count: 9)
    @State private var c: [Bool] = Array(repeating: false, count: 9)
    @State private var cx: [Bool] = Array(repeating: false, count: 9)
    @State private var count = 0
    var body: some View {
        
        ZStack {
        Image("empty grid")
            .resizable()
            .frame(width: 300, height: 300, alignment: .center)
            
            ForEach(0..<9, id: \.self) { index in
                if x[index] {
                    Image(systemName: "cross.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .foregroundColor(.black)
                        .rotationEffect(.degrees(45))
                        .offset(position(for: index))
                }
                if c[index] {
                    Image(systemName: "circle")
                       .resizable()
                       .aspectRatio(contentMode: .fit)
                       .frame(width: 80, height: 80)
                       .foregroundColor(.black)
                       .offset(position(for: index))
                }
            }
            
            VStack {
                ForEach(0..<3) { row in
                    HStack {
                        ForEach(0..<3) { column in
                            Button {
                                togglePosition(row: row, column: column)
                                if iswinner(a: x) {
                                    gameover = true
                                    tie = false
                                }
                                if count < 8 {
                                    count += 2
                                    rand()
                                }
                                else {
                                    gameover = true
                                }
                                if iswinner(a: c) {
                                    gameover = true
                                    computer = true
                                    tie = false
                                }
                            } label: {
                                Text("")
                                    .frame(width: 100.0, height: 85.0)
                                    .padding()
                            }
                        }
                    }
                }
            }
            if gameover {
                VStack {
                    Spacer()
                    if tie {
                        Text("It's a tie!")
                            .font(.largeTitle.bold())
                    }
                    else {
                        if computer {
                            Text("Computer wins!")
                                .font(.largeTitle.bold())
                        }
                        else {
                            Text("Player wins!!!")
                                .font(.largeTitle.bold())
                        }
                    }
                    
                    Spacer()
                    Button("HOME") {
                        backhome = true
                    }
                    .font(.title2)
                    .frame(width: 100, height: 40)
                    .background(Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .shadow(radius: 15))
                    .fullScreenCover(isPresented: $backhome) {
                        ContentView()
                    }
                    Spacer()
                }
                .frame(width: 160.0, height: 150)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding()
                .background(Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 15))
            }

        }
    }
    func position(for index: Int) -> CGSize {
            let row = index / 3
            let column = index % 3
            let xOffset = CGFloat(column - 1) * 100
            let yOffset = CGFloat(row - 1) * 100
            return CGSize(width: xOffset, height: yOffset)
    }
    func togglePosition(row: Int, column: Int) {
        let index = row * 3 + column
        x[index].toggle()
        cx[index].toggle()
        }
    
    func rand() {
       var randint = Int.random(in: 0..<9)
        while cx[randint] {
            randint = Int.random(in: 0..<9)
        }
        c[randint].toggle()
        cx[randint].toggle()
    }
    
    func iswinner(a : [Bool]) -> Bool {
        var bol = false
        let winningCombinations: [[Int]] = [
                [0, 1, 2], [3, 4, 5], [6, 7, 8],
                [0, 3, 6], [1, 4, 7], [2, 5, 8],
                [0, 4, 8], [2, 4, 6]]
        for combination in winningCombinations {
            if a[combination[0]] && a[combination[1]] && a[combination[2]] {
                bol = true
                break
            }
        }
        return bol
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        SecondContentView()
    }
}
