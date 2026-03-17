//
//  AuthService.swift
//  Bike App
//
//  Created by Denis on 24.02.2026.
//

import Foundation

enum AuthError: Error {
    case invalidURL
    case invalidResponse
    case server(statusCode: Int, body: String?)
    case missingToken
}

final class AuthService {
    private let baseURL: URL
    private let session: URLSession

    init(baseURL: URL = URL(string: "http://localhost:3000")!, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    func register(email: String, password: String, name: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "/auth/register", relativeTo: baseURL) else {
            completion(.failure(AuthError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let payload = RegisterPayload(email: email, password: password, name: name)
        do {
            request.httpBody = try JSONEncoder().encode(payload)
        } catch {
            completion(.failure(error))
            return
        }

        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let http = response as? HTTPURLResponse else {
                completion(.failure(AuthError.invalidResponse))
                return
            }
            guard (200...299).contains(http.statusCode) else {
                let body = data.flatMap { String(data: $0, encoding: .utf8) }
                completion(.failure(AuthError.server(statusCode: http.statusCode, body: body)))
                return
            }
            completion(.success(()))
        }.resume()
    }

    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "/auth/login", relativeTo: baseURL) else {
            completion(.failure(AuthError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let payload = LoginPayload(email: email, password: password)
        do {
            request.httpBody = try JSONEncoder().encode(payload)
        } catch {
            completion(.failure(error))
            return
        }

        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let http = response as? HTTPURLResponse else {
                completion(.failure(AuthError.invalidResponse))
                return
            }
            guard (200...299).contains(http.statusCode) else {
                let body = data.flatMap { String(data: $0, encoding: .utf8) }
                completion(.failure(AuthError.server(statusCode: http.statusCode, body: body)))
                return
            }
            guard let data = data else {
                completion(.failure(AuthError.missingToken))
                return
            }
            if let token = Self.parseToken(from: data) {
                completion(.success(token))
            } else {
                completion(.failure(AuthError.missingToken))
            }
        }.resume()
    }

    func fetchMe(token: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "/auth/me", relativeTo: baseURL) else {
            completion(.failure(AuthError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let http = response as? HTTPURLResponse else {
                completion(.failure(AuthError.invalidResponse))
                return
            }
            guard (200...299).contains(http.statusCode) else {
                let body = data.flatMap { String(data: $0, encoding: .utf8) }
                completion(.failure(AuthError.server(statusCode: http.statusCode, body: body)))
                return
            }
            completion(.success(()))
        }.resume()
    }

    private static func parseToken(from data: Data) -> String? {
        if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            if let token = json["token"] as? String { return token }
            if let token = json["accessToken"] as? String { return token }
        }
        return nil
    }
}

private struct RegisterPayload: Codable {
    let email: String
    let password: String
    let name: String
}

private struct LoginPayload: Codable {
    let email: String
    let password: String
}
