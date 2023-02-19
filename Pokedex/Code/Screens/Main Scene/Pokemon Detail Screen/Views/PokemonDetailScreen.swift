//
//  PokemonDetailScreen.swift
//  Pokedex
//
//  Created by Justin Cook on 2/14/23.
//

import SwiftUI
import Shimmer

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
        Group {
            if model.isLoaded {
                mainSection
            }
            else {
                mainSection
                    .redacted(reason: .placeholder)
                    .shimmering()
            }
        }
        .animation(.spring(),
                   value: model.isLoaded)
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
            .refreshable {
                model.refresh()
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
                        Spacer()
                        pokemonOrderTextView
                    }
                    .padding(.top, topSectionTopPadding)
                .padding(.leading,
                         topSectionLeadingPadding)
                .zIndex(5)
                
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
        ScrollView(.horizontal,
                   showsIndicators: false) {
            HStack (alignment: .center, spacing: 50) {
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
                       .padding(.leading,
                                infoSectionLeadingPadding)
                
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
                       .minimumScaleFactor(1)
                       .foregroundColor(model.infoSectionTextColor)
                
                Spacer()
            }
        }
    }
    
    var baseStatsSection: some View {
        VStack {
            HStack {
                Text("Base Stats")
                    .withFont(model.infoSectionTitleFont)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .foregroundColor(model.infoSectionTitleFontColor)
             Spacer()
            }
            .padding(.bottom, 10)
            
            ForEach(PokemonStats.allCases, id: \.rawValue) { stat in
                let statBaseValue: Int = model.getStatFor(pokemonStat: stat)
                   
                    HStack (alignment: .center,
                            spacing: 10) {
                        Group {
                            Text(stat == .hp ? stat.rawValue.uppercased() : stat.rawValue.capitalized)
                                .withFont(model.infoSectionHeaderFont)
                                .foregroundColor(model.infoSectionHeaderTextColor)

                            Text(String(statBaseValue))
                                .withFont(model.infoSectionFont)
                                .fontWeight(model.infoSectionFontWeight)
                                .foregroundColor(model.infoSectionTextColor)
                        }
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .minimumScaleFactor(1)
                        
                        Spacer()
                        
                        BaseStatProgressView(progress: Double(statBaseValue),
                                             maxProgressAmount: 100)
                    }
                .padding(.trailing,
                         infoSectionLeadingPadding)
                        
        }
            
            HStack (alignment: .center,
                    spacing: 10) {
                Group {
                    Text("Total")
                        .withFont(model.infoSectionHeaderFont)
                        .foregroundColor(model.infoSectionHeaderTextColor)
                    
                    Text(String(model.pokemonStatsTotal))
                        .withFont(model.infoSectionFont)
                        .fontWeight(model.infoSectionFontWeight)
                        .foregroundColor(model.infoSectionTextColor)
                }
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .minimumScaleFactor(1)
                
                Spacer()
                
                BaseStatProgressView(progress: Double(model.pokemonStatsTotal),
                                     maxProgressAmount: 600)
            }
        .padding(.trailing,
                 infoSectionLeadingPadding)
        }
        .padding(.leading,
                 infoSectionLeadingPadding)
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
            
            Spacer()
        }
    }
    
    var pokemonNameTextView: some View {
        HStack {
            Text(model.pokemonName)
                .withFont(model.nameFont)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .minimumScaleFactor(0.9)
                .foregroundColor(model.nameTextColor)
            
            Spacer()
        }
    }
    
    var pokemonOrderTextView: some View {
            HStack {
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
