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

    var errorMessage: String {
        switch self {
        case .emptyOneNumberInput:
            return "Please enter number."
        case .emptySeveralNumberInput:
            return "Please enter numbers."
        case .redundantInput:
            return "Please enter only one number."
        case .insufficientInput:
            return "Please enter more than one number."
        case .incorrectRangeInput:
            return "Please enter two numbers, the first of which is less than the second."
        }
    }
}

class APIService {
    func fetchFactFromAPI(numberType: NumberType, string: String?) async throws -> [Fact] {
        var facts: [Fact] = []

        switch numberType {
        case .userNumber:
            guard let number = string?.trimmingCharacters(in: .whitespaces),
                  !number.isEmpty
            else {
                throw ValidationError.emptyOneNumberInput
            }

            guard number.components(separatedBy: " ").count == 1 else {
                throw ValidationError.redundantInput
            }

            let fact = try await fetchFactAboutUserNumberFromAPI(number: number)
            facts.append(fact)
        case .randomNumber:
            let fact = try await fetchFactAboutRandomNumberInRangeFromAPI(min: nil, max: nil)
            facts.append(fact)
        case .numberInRange:
            guard let numbers = string?.trimmingCharacters(in: .whitespaces).components(separatedBy: " "),
                  !numbers.isEmpty
            else {
                throw ValidationError.emptySeveralNumberInput
            }

            guard numbers.count == 2,
                  let firstNumber = Int(numbers[0]),
                  let secondNumber = Int(numbers[1]),
                  firstNumber <= secondNumber
            else {
                throw ValidationError.incorrectRangeInput
            }

            let fact = try await fetchFactAboutRandomNumberInRangeFromAPI(min: numbers[0], max: numbers[1])
            facts.append(fact)
        case .multipleNumbers:
            guard let number = string?.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: ","),
                  !number.isEmpty
            else {
                throw ValidationError.emptySeveralNumberInput
            }

            guard number.count > 1 else {
                throw ValidationError.insufficientInput
            }

            let factData = try await fetchFactsAboutMultipleNumbersFromAPI(numbers: number)
            for fact in factData.values {
                facts.append(fact)
            }
        }

        return facts
    }

    func fetchFactAboutUserNumberFromAPI(number: String) async throws -> Fact {
        let baseURL = "http://numbersapi.com"
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw URLError(.badURL)
        }

        urlComponents.path = "/\(number)"

        urlComponents.queryItems = [
            URLQueryItem(name: "json", value: nil)
        ]

        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let decoded = try JSONDecoder().decode(Fact.self, from: data)

        return decoded
    }

    func fetchFactAboutRandomNumberInRangeFromAPI(min: String?, max: String?) async throws -> Fact {
        let baseURL = "http://numbersapi.com"
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw URLError(.badURL)
        }

        urlComponents.path = "/random"

        urlComponents.queryItems = [
            URLQueryItem(name: "json", value: nil)
        ]

        if let min = min, let max = max {
            urlComponents.queryItems?.append(URLQueryItem(name: "min", value: min))
            urlComponents.queryItems?.append(URLQueryItem(name: "max", value: max))
        }

        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let decoded = try JSONDecoder().decode(Fact.self, from: data)

        return decoded
    }

    func fetchFactsAboutMultipleNumbersFromAPI(numbers: String) async throws -> [String: Fact] {
        let urlString = "http://numbersapi.com/\(numbers)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, _) = try await URLSession.shared.data(for: request)

        let decoded = try JSONDecoder().decode([String: Fact].self, from: data)

        return decoded
    }
}
