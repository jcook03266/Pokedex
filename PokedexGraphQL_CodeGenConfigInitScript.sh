#!/bin/sh

# Initialize the code generation configuration JSON
./apollo-ios-cli init --schema-name PokemonSchema --module-type embeddedInTarget --target-name Pokedex

# Generate the required schema and GraphQL swift code
./apollo-ios-cli generate}
