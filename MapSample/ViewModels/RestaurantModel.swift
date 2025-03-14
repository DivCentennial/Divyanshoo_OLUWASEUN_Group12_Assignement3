//
//  RestaurantModel.swift
//  MapSample
//
//  Created by Divyanshoo Sinha on 2025-03-14.
//

import Foundation

// MARK: - Restaurant Model

class RestaurantModel: ObservableObject {
    let bakeries = [
        Restaurant(latitude: 43.6532, longitude: -79.3832, name: "Charlie's Chocolate Factory 🍫", typeOfFood: "Bakery"),
        Restaurant(latitude: 43.6645, longitude: -79.4125, name: "Cake Island 🎂", typeOfFood: "Bakery"),
        Restaurant(latitude: 43.6578, longitude: -79.3762, name: "Lucknow Sweets 🍡", typeOfFood: "Bakery"),
        Restaurant(latitude: 43.6421, longitude: -79.4100, name: "Alibaba 40 Sweets 🍮", typeOfFood: "Bakery"),
        Restaurant(latitude: 43.6692, longitude: -79.3915, name: "Dodo Donuts 🍩", typeOfFood: "Bakery"),
        Restaurant(latitude: 43.6428, longitude: -79.3789, name: "Meta Muffin 🧁", typeOfFood: "Bakery")
    ]
    
    let mexicanRestaurants = [
        Restaurant(latitude: 43.6512, longitude: -79.3752, name: "Div Diablo 😈", typeOfFood: "Mexican"),
        Restaurant(latitude: 43.6445, longitude: -79.4025, name: "Orlando Kitchen 🍽️", typeOfFood: "Mexican"),
        Restaurant(latitude: 43.6578, longitude: -79.3902, name: "MEDUOYE Dining 🍴", typeOfFood: "Mexican"),
        Restaurant(latitude: 43.6421, longitude: -79.3850, name: "Gambit Burritos 🌯", typeOfFood: "Mexican"),
        Restaurant(latitude: 43.6582, longitude: -79.4105, name: "El Loco de Tacos 🌮", typeOfFood: "Mexican"),
        Restaurant(latitude: 43.6478, longitude: -79.3769, name: "Escobar Eatery 🧑🏽‍🍳", typeOfFood: "Mexican")
    ]
}
