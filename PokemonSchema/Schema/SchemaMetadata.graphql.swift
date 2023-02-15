// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol PokemonSchema_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == PokemonSchema.SchemaMetadata {}

public protocol PokemonSchema_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == PokemonSchema.SchemaMetadata {}

public protocol PokemonSchema_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == PokemonSchema.SchemaMetadata {}

public protocol PokemonSchema_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == PokemonSchema.SchemaMetadata {}

public extension PokemonSchema {
  typealias ID = String

  typealias SelectionSet = PokemonSchema_SelectionSet

  typealias InlineFragment = PokemonSchema_InlineFragment

  typealias MutableSelectionSet = PokemonSchema_MutableSelectionSet

  typealias MutableInlineFragment = PokemonSchema_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    public static func objectType(forTypename typename: String) -> Object? {
      switch typename {
      case "query_root": return PokemonSchema.Objects.Query_root
      case "pokemon_v2_pokemon": return PokemonSchema.Objects.Pokemon_v2_pokemon
      case "pokemon_v2_pokemonspecies": return PokemonSchema.Objects.Pokemon_v2_pokemonspecies
      case "pokemon_v2_pokemonegggroup": return PokemonSchema.Objects.Pokemon_v2_pokemonegggroup
      case "pokemon_v2_egggroup": return PokemonSchema.Objects.Pokemon_v2_egggroup
      case "pokemon_v2_pokemonability": return PokemonSchema.Objects.Pokemon_v2_pokemonability
      case "pokemon_v2_ability": return PokemonSchema.Objects.Pokemon_v2_ability
      case "pokemon_v2_pokemonstat": return PokemonSchema.Objects.Pokemon_v2_pokemonstat
      case "pokemon_v2_stat": return PokemonSchema.Objects.Pokemon_v2_stat
      case "pokemon_v2_pokemontype": return PokemonSchema.Objects.Pokemon_v2_pokemontype
      case "pokemon_v2_type": return PokemonSchema.Objects.Pokemon_v2_type
      case "pokemon_v2_pokemonsprites": return PokemonSchema.Objects.Pokemon_v2_pokemonsprites
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}