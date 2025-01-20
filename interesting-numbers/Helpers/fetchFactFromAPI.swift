//
//  fetchImagesFromAPI.swift
//  interesting-numbers
//
//  Created by Мария Анисович on 09.01.2025.
//

import Foundation

enum NumberType {
    case userNumber
    case randomNumber
    case numberInRange
    case multipleNumbers
}

struct Fact: Codable {
    let text: String
    let number: Double
}

enum ValidationError: Error {
    case emptyOneNumberInput
    case emptySeveralNumberInput
    case redundantInput
    case insufficientInput
    case incorrectRangeInput
}

func fetchFactFromAPI(numberType: NumberType, string: String?) async throws -> [Fact] {
    var facts: [Fact] = []

    switch numberType {
    case .userNumber:
        if let number = string?.trimmingCharacters(in: .whitespaces), !number.isEmpty {
            if number.components(separatedBy: " ").count == 1 {
                try facts.append(await fetchFactAboutUserNumberFromAPI(number: number))
            } else {
                throw ValidationError.redundantInput
            }
        } else {
            throw ValidationError.emptyOneNumberInput
        }
    case .randomNumber:
        try facts.append(await fetchFactAboutRandomNumberInRangeFromAPI(min: nil, max: nil))
    case .numberInRange:
        if let numbers = string?.trimmingCharacters(in: .whitespaces).components(separatedBy: " "), !numbers.isEmpty {
            if numbers.count == 2, let firstNumber = Int(numbers[0]), let secondNumber = Int(numbers[1]), firstNumber <= secondNumber {
                try facts.append(await fetchFactAboutRandomNumberInRangeFromAPI(min: numbers[0], max: numbers[1]))
            } else {
                throw ValidationError.incorrectRangeInput
            }
        } else {
            throw ValidationError.emptySeveralNumberInput
        }
    case .multipleNumbers:
        if let number = string?.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: ","), !number.isEmpty {
            if number.count > 1 {
                let factData = try await fetchFactsAboutMultipleNumbersFromAPI(numbers: number)
                for fact in factData.values {
                    facts.append(fact)
                }
            } else {
                throw ValidationError.insufficientInput
            }
        } else {
            throw ValidationError.emptySeveralNumberInput
        }
    }
    return facts
}

func fetchFactAboutUserNumberFromAPI(number: String) async throws -> Fact {
    let baseURL = "http://numbersapi.com"
    var urlComponents = URLComponents(string: baseURL)!

    urlComponents.path = "/\(number)"

    urlComponents.queryItems = [
        URLQueryItem(name: "json", value: nil)
    ]

    let url = urlComponents.url!

    let (data, _) = try await URLSession.shared.data(from: url)

    let decoded = try JSONDecoder().decode(Fact.self, from: data)

    return decoded
}

func fetchFactAboutRandomNumberInRangeFromAPI(min: String?, max: String?) async throws -> Fact {
    let baseURL = "http://numbersapi.com"
    var urlComponents = URLComponents(string: baseURL)!

    urlComponents.path = "/random"

    urlComponents.queryItems = [
        URLQueryItem(name: "json", value: nil)
    ]

    if let min = min, let max = max {
        urlComponents.queryItems?.append(URLQueryItem(name: "min", value: min))
        urlComponents.queryItems?.append(URLQueryItem(name: "max", value: max))
    }

    let url = urlComponents.url!

    let (data, _) = try await URLSession.shared.data(from: url)

    let decoded = try JSONDecoder().decode(Fact.self, from: data)

    return decoded
}

func fetchFactsAboutMultipleNumbersFromAPI(numbers: String) async throws -> [String: Fact] {
    let urlString = "http://numbersapi.com/\(numbers)"
    let url = URL(string: urlString)!

    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let (data, _) = try await URLSession.shared.data(for: request)

    let decoded = try JSONDecoder().decode([String: Fact].self, from: data)

    return decoded
}
