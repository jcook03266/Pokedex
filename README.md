<div align="center">
 
# Pokedex

[![Swift Version badge](https://img.shields.io/badge/Swift-5.7.1-orange.svg)](https://shields.io/)
[![Platforms description badge](https://img.shields.io/badge/Platform-iOS-blue.svg)](https://shields.io/)

<div align="center">

<img src="https://github.com/jcook03266/Pokedex/blob/main/Resource/pokedexHero.png" width = "800">

</div>

<div align="left">
 
## Project Summary:

A fun powerful and performant little Pokedex application inspired by this amazing design:
https://dribbble.com/shots/6540871-Pokedex-App/attachments/6540871-Pokedex-App?mode=media

This project uses a GraphQL backend layer powered by:
https://pokeapi.co/
 
## Memory Management and Performance Optimization
The app uses a staggered tier system for displaying Pokemon data, with the main screen using a low detail model to display basic information about the Pokemon in question. When tapping on a detail view a detailed Pokemon data model is fetched and loaded instantly, and this detailed model is then put into a FIFO cache where the oldest model is evicted if the user reaches an arbitrary threshold (i.e 10 detailed models).
 
* The revolving FIFO model cache is for added memory management and UX since it allows a user to access past Pokemon data even when they're not online, and it keeps the RAM usage low which allows the app to be very performant.
 
### Loading and Streaming
* Lazy loading is used for both the main screen and detail views to give the user access to the UI while things load, it's a much better approach than blocking them from using the app entirely if an internet connection isn't readily available. But, if a user gets an internet connection after launching the app then can just refresh either screen to re-fetch the respective data they need to view.
 
* Combine was used for streaming pokemon data to each screen from the data provider and data store. And it was through publisher subscriptions that filtering was greatly simplified as you can just attach a map operation to a subscriber and filter the publisher's stream through whatever criteria you want. This made implementing the search bar super simple and versatile as the user can search up colors, names, numbers, and types and get whatever Pokemon they want based off of text alone.
 
### Fetching and Storing
* Swift Concurrency and completion blocks also made using GraphQL very painless and thread safe, as each query was passed through a service adapter and the necessary data was brought back without having to introduce boiler plate into the view model; using these techniques saved on time and energy for this project.
 
* Downloaded images were stored locally in the file manager and reused whenever a user scrolled back to past content, this greatly improves performance and UX. You can see the performance when you scroll all the way down on the main screen; a thousand images loaded in parallel with minor hitches in frame rendering is without a doubt ideal.
 
### Navigation
* This app has a router + coordinator + MVVM pattern under the hood, any new screens can be added painlessly by extending the existing architecture and plugging in those additional modules with their protocol boilerplate. 
 
-> Things to note:
* Some of the sprite images for Pokemons with order numbers in the 1000s aren't available, and this is due to them being missing from Poke API's image source directory.
 
* The GQL call in the beginning blocks the UI momentarily, this can be optimized in the future by probably isolating the two thread intensive operations from each other by a factor of time instead of doing them in parallel when the app first launches; which might be causing a sort of race condition for memory access between threads.
 
## Takeaways from this project:
- Objective-C is a pretty versatile language and can be combined with Swift out of the box, and this is a great trait because a lot of legacy codebases need upgrades, but the possibility of breaking changes and constant QA would prevent that from happening; the interoperability between these two languages destroys that barrier and allows for modularity. I was able to integrate some Objective-C classes and interface with Swift without breaking a sweat, and these classes do their job just fine, no drawbacks or anything, and this just shows the power the language still has even in this modern ecosystem.
 
- GraphQL is really cool, but one hassle is specifying typealiases to get around the giant type chains when you want to access a data model tied to a query or mutation. It's useful but takes away from the usual setup of specifying your own data models and having control over them as the GQL type models have immutable properties.
 
- SwiftUI has really matured to the point where defining custom UIViews to handle niche user interactions isn't necessary anymore. I would've liked to include a UIView, or a storyboard view, but doing so would've required more boilerplate and just wouldn't interface well with the reactive UI I set out to create, optimize, and maintain. 

## Design Patterns Used:
* Coordinator
* Router
* MVVM
* Dependency Injection
* Services
* Data Provider
* Data Store
* Manager
* Singleton
* Adapter
* Protocol

## Libraries Used:
* Sheathed-TextField-SwiftUI
* swift-collections
* SwiftUI-Shimmer
* Apollo-iOS

## Supported Orientations:
* Landscape
* Portrait

## Supported Platforms:
* iOS
* iPadOS

</div>

<div align="center">

## Portrait Demo:

https://user-images.githubusercontent.com/63657230/219216667-f1dafdbf-d1b9-4f0e-a719-b3bc36895d3f.mp4

## Landscape Mode Demo:

https://user-images.githubusercontent.com/63657230/219472859-9880312c-7e5c-411c-88e2-cfffe8bd7b9e.mp4

Thanks for reading, check out more of my repos for more code and design ideas!
</div>
