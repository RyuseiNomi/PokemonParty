
import SwiftUI
import QGrid

struct TopView: View {
    
    @State public var inputedName: String = ""
    @EnvironmentObject public var appState: AppState
    
    var body: some View {
        VStack() {
            if self.appState.pokemonObject.weakTypes.isEmpty {
                Text("弱点はありません")
            }
            QGrid(self.appState.pokemonObject.weakTypes,
                  columns: 3,
                  vSpacing: 15,
                  hSpacing: 5,
                  vPadding: 10,
                  hPadding: 10,
                  isScrollable: true
            ) { type in
                TypeCell(type: type)
            }
            if self.appState.pokemonObject.pokemons.isEmpty {
                Text("ポケモンを入力する")
            }
            QGrid(self.appState.pokemonObject.pokemons,
                  columns: 2,
                  vSpacing: 15,
                  hSpacing: 5,
                  vPadding: 10,
                  hPadding: 10,
                  isScrollable: true
            ) { pokemon in
                PokemonCell(pokemon: pokemon)
            }
            HStack() {
                TextField("ポケモンを入力", text: $inputedName, onCommit: {
                    //self.validateInputedName(inputedName: self.inputedMemberName)
                    let pi = PokemonInteractor(appState: self.appState)
                    pi.addPokemon(self.inputedName)
                    let ti = TypeInteractor(appState: self.appState)
                    ti.updateWeakType(self.inputedName)
                })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 30, trailing: 5))
                Button(action:{
                    //self.validateInputedName(inputedName: self.inputedMemberName)
                    let pi = PokemonInteractor(appState: self.appState)
                    pi.addPokemon(self.inputedName)
                    let ti = TypeInteractor(appState: self.appState)
                    ti.updateWeakType(self.inputedName)
                }) {
                    DecisionButton(label: "追加", maxWidth: 100)
                }
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 30, trailing: 5))
            }
        }
        .onAppear(perform: {
            // タイプ相性の読み込み
            let ti = TypeInteractor(appState: self.appState)
            ti.setTypeCompatibility()
        })
        .background(Color(red: 77/255, green: 77/255, blue: 77/255)) //gray
    }
}

struct PokemonCell: View {
    
    var pokemon: Pokemon
    @EnvironmentObject public var appState: AppState
    
    var body: some View {
        ZStack() {
            HStack() {
                Image(systemName: "hare.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .frame(maxWidth: 30, maxHeight: 30)
                    .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing:10))
                Text(pokemon.name)
                    .foregroundColor(Color(red: 105/255, green: 105/255, blue: 105/255))
                    .font(Font.custom("Helvetica-Light", size: 16))
                Spacer()
                Button(action: {
                    let pi = PokemonInteractor(appState: self.appState)
                    pi.deletePokemon(self.pokemon.name)
                }) {
                    Text("×")
                        .foregroundColor(Color(red: 105/255, green: 105/255, blue: 105/255))
                        .font(Font.custom("Helvetica-Light", size: 20))
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing:5))
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 255/255, green: 255/255, blue: 255/255))
        }
        .cornerRadius(10)
        .shadow(color: Color(red: 173/255, green: 216/255, blue: 230/255), radius: 1, x: 0, y: 5) //lightblue
    }
}

struct TypeCell: View {
    
    var type: Type
    @EnvironmentObject public var appState: AppState
    
    var body: some View {
        ZStack() {
            HStack() {
                Image(systemName: "flame.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .frame(maxWidth: 30, maxHeight: 30)
                    .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing:10))
                Text(type.typeName)
                    .foregroundColor(Color(red: 105/255, green: 105/255, blue: 105/255))
                    .font(Font.custom("Helvetica-Light", size: 16))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing:5))
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 255/255, green: 255/255, blue: 255/255))
        }
        .cornerRadius(10)
        .shadow(color: Color(red: 173/255, green: 216/255, blue: 230/255), radius: 1, x: 0, y: 5) //lightblue
    }
}

struct DecisionButton: View {
    
    public var label:String
    public var maxWidth:CGFloat
    @EnvironmentObject public var appState: AppState
    
    var body: some View {
        ZStack(alignment: .center) {
            HStack(alignment: .center) {
                Text(self.label)
                    .foregroundColor(Color(red: 255/255, green: 255/255, blue: 255/255)) //white
                    .font(Font.custom("Helvetica-Light", size: 20))
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            }
            .frame(minWidth: 0, maxWidth: self.maxWidth, alignment: .center)
            .background(Color(red: 255/255, green: 127/255, blue: 80/255))
        }
        .cornerRadius(10)
        .shadow(color: Color(red: 173/255, green: 216/255, blue: 230/255), radius: 1, x: 0, y: 5) //lightblue
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
