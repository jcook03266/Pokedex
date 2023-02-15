//
//  PokemonImageFetcher.swift
//  Pokedex
//
//  Created by Justin Cook on 2/14/23.
//

import Foundation
import SwiftUI
import Combine

/// Store specifically meant for fetching and storing images corresponding to the image assets linked to each coin model. Images are stored in the file system versus local memory in order to preserve performance
class PokemonImageFetcher: ObservableObject {
    // MARK: - Published
    /// Used to determine the current state of the async loading of the specified image asset
    @Published var isLoading: Bool = true
    
    // MARK: - Dependencies
    struct Dependencies: InjectableServices {
        let imageDownloader: ImageDownloaderService = inject()
    }
    let dependencies = Dependencies()
    
    // MARK: - Default URL for target sprite type
    var imageURLRoot: String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/"
    }
    
    // MARK: Properties
    // Pokemon Model Information
    private let pokemonModel: MinimalPokemonModel
    private var pokemonModelImageURL: URL {
        let constructedURL = imageURLRoot + String(pokemonModel.element.id) + ".png"
        
        guard let url = constructedURL.asURL
        else {
            ErrorCodeDispatcher.SwiftErrors.triggerPreconditionFailure(for: .urlCouldNotBeParsed, using: constructedURL)()
        }
        
        return url
    }
    
    // Subscriptions
    /// Keeps subscriptions alive and stores them when they're cancelled
    private var cancellables = Set<AnyCancellable>()
    
    // Caching
    private var imageFileManager = LocalFileDirector.imageFileManager
    private var shouldCacheImages = true
    
    init(pokemonModel: MinimalPokemonModel) {
        self.pokemonModel = pokemonModel
    }
    
    /// Fetches the image from the local file system if it exists, if not then the image is downloaded and then cached appropriately
    func getImage(completionHandler: @escaping ((UIImage) -> Void)) {
        do {
            try fetchImageFromLocal(completionHandler: completionHandler)
        } catch {
            downloadImage(completionHandler: completionHandler)
        }
    }
    
    /// Remote Data Access
    private func downloadImage(completionHandler: @escaping ((UIImage) -> Void)) {
        dependencies
            .imageDownloader
            .getImage(for: pokemonModelImageURL,
                      imageName: String(pokemonModel.element.id),
                      canCacheImage: shouldCacheImages)
        
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.isLoading = false
            } receiveValue: { parsedImage in
                completionHandler(parsedImage)
            }
            .store(in: &cancellables)
    }
    
    /// Local Data Access
    private func fetchImageFromLocal(completionHandler: @escaping ((UIImage) -> Void)) throws {
        let fileName = String(pokemonModel.element.id)
        let folderName = ImageFileManager
            .ImageDirectoryNames
            .coinImages
        
        guard let savedImage = imageFileManager.getImage(imageName: fileName,
                                                      folderName: folderName)
        else {
            throw ErrorCodeDispatcher
                .FileManagerErrors
                .throwError(for: .imageNotFound(fileName: fileName,
                                                folderName: folderName.rawValue))
        }
        
        self.isLoading = false
        completionHandler(savedImage)
    }
}

