//
//  PokemonDetailScreen.swift
//  Pokedex
//
//  Created by Justin Cook on 2/14/23.
//

import SwiftUI

struct PokemonDetailScreen: View {
    // MARK: - Observed
    @StateObject var model: PokemonDetailScreenViewModel
    
    // MARK: - Dimensions
    private let height: CGFloat = 140,
                cornerRadius: CGFloat = 20,
                shadowRadius: CGFloat = 3,
                shadowOffset: CGSize = .init(width: 0,
                                             height: 3),
                pokemonTypePillCornerRadius: CGFloat = 40,
                pokemonTypePillHeight: CGFloat = 25,
                pokemonImageSize: CGSize = .init(width: 300,
                                                 height: 300),
                backButtonSize: CGSize = .init(width: 20,
                                               height: 20),
                backgroundArtImageSize: CGSize = .init(width: 250,
                                                       height: 250),
                backgroundArtImageSize_2: CGSize = .init(width: 150,
                                                       height: 150),
                backgroundArtImageSize_3: CGSize = .init(width: 150,
                                                       height: 150)
    
    // MARK: - Padding:
    private let bottomSectionTopPadding: CGFloat = 350,
                leadingPadding: CGFloat = 10,
                topSectionLeadingPadding: CGFloat = 30,
                topSectionTopPadding: CGFloat = 50,
                pokemonTypePillPadding: CGFloat = 10,
                pokemonOrderTextViewTrailingPadding: CGFloat = 20,
                infoSectionLeadingPadding: CGFloat = 30
    
    var pokemonImageTopPadding: CGFloat {
        return pokemonImageSize.height/5
    }
    
    var body: some View {
        mainSection
    }
}

// MARK: - View Sections
extension PokemonDetailScreen {
    var mainSection: some View {
        GeometryReader { geom in
            ZStack {
            ScrollView(.vertical) {
                ZStack {
                    bottomSection
                    topSection
                }
            }
            backButton
        }
            .background(content: {
                ZStack {
                    Rectangle()
                        .fill(model.heroBackgroundColor)
                        .ignoresSafeArea()
                    
                    backgroundArtImage
                    backgroundArtImage_2
                    backgroundArtImage_3
                }
            })
            .frame(width: geom.size.width,
                   height: geom.size.height)
        }
    }
    
    var topSection: some View {
        ZStack {
            
            VStack(alignment: .center) {
                    HStack {
                        VStack {
                            pokemonNameTextView
                            pokemonTypesList
                        }
                        pokemonOrderTextView
                        Spacer()
                    }
                    .padding(.top, topSectionTopPadding)
                .padding(.leading,
                         topSectionLeadingPadding)
                
                pokemonImage
                
                Spacer()
            }
        }
    }
    
    var bottomSection: some View {
            ZStack {
                Rectangle()
                    .fill(model.backgroundColor)
                    .cornerRadius(40,
                                  corners: [.topLeft, .topRight])
                    .padding(.bottom, -1000)
                
                VStack {
                    sectionSwitchers
                    
                    Divider()
                        .frame(height: 2)
                    
                    
                    aboutSection
                        .padding(.top, 20)
                    
                    baseStatsSection
                        .padding(.top, 40)
                    
                    Spacer()
                }
                .padding(.top, 70)
            }
            .padding(.top,
                     bottomSectionTopPadding)
    }
}

// MARK: - Subviews
extension PokemonDetailScreen {
    var sectionSwitchers: some View {
        HStack(alignment: .center, spacing: 30) {
            Text("About")
            
            Group {
                Text("Base Stats")
                
                Text("Evolution")
                
                Text("Moves")
            }
            .foregroundColor(model.infoSectionHeaderTextColor)
        }
        .withFont(model.infoSectionHeaderFont)
    }
    
    var aboutSection: some View {
        HStack (alignment: .center, spacing: 80) {
            VStack(alignment: .leading,
                   spacing: 20) {
                Text("Species")
                Text("Height")
                Text("Weight")
                Text("Abilities")
            }
            .withFont(model.infoSectionHeaderFont)
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .foregroundColor(model.infoSectionHeaderTextColor)
            
            VStack(alignment: .leading,
                   spacing: 20) {
                Text(model.pokemonSpecies)
                Text(model.pokemonHeight)
                Text(model.pokemonWeight)
                Text(model.pokemonAbilities)
            }
            .withFont(model.infoSectionFont)
            .fontWeight(model.infoSectionFontWeight)
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .foregroundColor(model.infoSectionTextColor)
            
            Spacer()
        }
        .padding(.leading,
                 infoSectionLeadingPadding)
    }
    
    var baseStatsSection: some View {
        VStack {
            HStack {
                Text("Base Stats")
                    .withFont(model.infoSectionTitleFont)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(model.infoSectionTitleFontColor)
             Spacer()
            }
            .padding(.leading,
                     infoSectionLeadingPadding)
            .padding(.bottom, 10)
            
            HStack (alignment: .center, spacing: 20) {
                VStack(alignment: .leading,
                       spacing: 20) {
                    Text(PokemonStats.hp.rawValue.uppercased())
                    Text(PokemonStats.attack.rawValue.capitalized)
                    Text(PokemonStats.defense.rawValue.capitalized)
                    Text(PokemonStats.special_attack.rawValue.capitalized)
                    Text(PokemonStats.special_defense.rawValue.capitalized)
                    Text(PokemonStats.speed.rawValue.capitalized)
                    Text("Total")
                }
                       .withFont(model.infoSectionHeaderFont)
                       .multilineTextAlignment(.center)
                       .lineLimit(1)
                       .minimumScaleFactor(0.5)
                       .foregroundColor(model.infoSectionHeaderTextColor)
                       .padding(.leading,
                                infoSectionLeadingPadding)
                
                VStack(alignment: .leading,
                       spacing: 20) {
                    HStack {
                        Text(String(model.pokemonHP))
                        BaseStatProgressView(progress: Double(model.pokemonHP),
                                             maxProgressAmount: 100)
                        .padding(.leading, 10)
                    }
                    
                    HStack {
                        Text(String(model.pokemonAttack))
                        BaseStatProgressView(progress: Double(model.pokemonAttack),
                                             maxProgressAmount: 100)
                        .padding(.leading, 10)
                    }
                    
                    HStack {
                        Text(String(model.pokemonDefense))
                        BaseStatProgressView(progress: Double(model.pokemonDefense),
                                             maxProgressAmount: 100)
                        .padding(.leading, 10)
                    }
                    
                    HStack {
                        Text(String(model.pokemonSpecialAttack))
                        BaseStatProgressView(progress: Double(model.pokemonSpecialAttack),
                                             maxProgressAmount: 100)
                        .padding(.leading, 10)
                    }
                    
                    HStack {
                        Text(String(model.pokemonSpecialDefense))
                        BaseStatProgressView(progress: Double(model.pokemonSpecialDefense),
                                             maxProgressAmount: 100)
                        .padding(.leading, 10)
                    }
                    
                    HStack {
                        Text(String(model.pokemonSpeed))
                        BaseStatProgressView(progress: Double(model.pokemonSpeed),
                                             maxProgressAmount: 100)
                        .padding(.leading, 10)
                    }
                    
                    HStack {
                        Text(String(model.pokemonStatsTotal))
                        BaseStatProgressView(progress: Double(model.pokemonStatsTotal),
                                             maxProgressAmount: 400)
                        .padding(.leading, 10)
                    }
                }
                       .withFont(model.infoSectionFont)
                       .fontWeight(model.infoSectionFontWeight)
                       .multilineTextAlignment(.center)
                       .lineLimit(1)
                       .minimumScaleFactor(0.5)
                       .foregroundColor(model.infoSectionTextColor)
                
                Spacer()
            }
        }
    }
    
    
    var pokemonTypesList: some View {
        HStack(alignment: .center,
               spacing: 10)
        {
            ForEach(model.pokemonTypes, id: \.self) { pokemonType in
                
                ZStack {
                    RoundedRectangle(cornerRadius: pokemonTypePillCornerRadius)
                        .fill(model.pokemonTypeChipletBackgroundColor)
                    
                    Text(pokemonType)
                        .withFont(model.pokemonTypeFont)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .foregroundColor(model.typeTextColor)
                        .padding(.horizontal,
                                 pokemonTypePillPadding)
                }
                .scaledToFit()
                .frame(height: pokemonTypePillHeight)
            }
        }
    }
    
    var pokemonNameTextView: some View {
        Text(model.pokemonName)
            .withFont(model.nameFont)
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .minimumScaleFactor(0.9)
            .foregroundColor(model.nameTextColor)
    }
    
    var pokemonOrderTextView: some View {
            HStack {
                Spacer()
                Text(model.pokemonIDNumber)
                    .withFont(model.pokemonOrderFont)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.9)
                    .foregroundColor(model.orderTextColor)
            }
            .padding(.trailing,
                     pokemonOrderTextViewTrailingPadding)
    }
    
    // MARK: - Background Hero Art
    var backgroundArtImage: some View {
        VStack {
            HStack {
                Spacer()
                model.backgroundArt
                    .fittedResizableTemplateImageModifier()
                    .foregroundColor(model.backgroundArtColor)
                    .frame(width: backgroundArtImageSize.width,
                           height: backgroundArtImageSize.height)
                    .padding(.top, bottomSectionTopPadding * 0.46)
                    .offset(x: 50)
            }
            
            Spacer()
        }
    }
    
    var backgroundArtImage_2: some View {
        VStack {
            HStack {
                model.backgroundArt_2
                    .fittedResizableTemplateImageModifier()
                    .foregroundColor(model.backgroundArtColor)
                    .frame(width: backgroundArtImageSize_2.width,
                           height: backgroundArtImageSize_2.height)
                    .offset(y: -100)
                
                Spacer()
            }
            
            Spacer()
        }
    }
    
    var backgroundArtImage_3: some View {
        VStack {
            HStack {
                model.backgroundArt_3
                    .fittedResizableTemplateImageModifier()
                    .foregroundColor(model.backgroundArtColor)
                    .frame(width: backgroundArtImageSize_3.width,
                           height: backgroundArtImageSize_3.height)
                    .padding(.top, bottomSectionTopPadding * 0.46)
                    .rotationEffect(.degrees(45))
                
                Spacer()
            }
            
            Spacer()
        }
    }
    
    var backButton: some View {
        VStack {
            HStack {
                Button {
                    model.dismiss()
                } label: {
                    model
                        .backButtonIcon
                        .filledResizableTemplateImageModifier()
                        .foregroundColor(Colors.permanent_white.0)
                        .frame(width: backButtonSize.width,
                               height: backButtonSize.height)
                }
                Spacer()
            }
            Spacer()
        }
        .padding(.leading,
                 topSectionLeadingPadding)
    }
    
    var pokemonImage: some View {
                PokemonImageView(model: .init(pokemonModel: model.selectedPokemon),
                                 size: .init(width: pokemonImageSize.width,
                                             height: pokemonImageSize.height))
                .padding(.top,
                         pokemonImageTopPadding)
        }
}

struct PokemonDetailScreen_Previews: PreviewProvider {
    static func getModel() -> PokemonDetailScreenViewModel {
        let coordinator: MainCoordinator = RootCoordinatorDispatcher(delegate: .shared).getRootCoordinatorFor(root: .mainCoordinator) as! MainCoordinator
        
        coordinator
            .router
            .currentlySelectedPokemon = .getMockData()
        
        let model: PokemonDetailScreenViewModel = .init(coordinator: coordinator,
                                                        router: coordinator.router)
        
        return model
    }
    
    static var previews: some View {
        PokemonDetailScreen(model: getModel())
    }
}
