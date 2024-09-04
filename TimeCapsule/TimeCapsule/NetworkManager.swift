import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func fetchEntries(completion: @escaping (Result<[Entry], Error>) -> Void) {
        guard let url = URL(string: "https://yourapi.com/api/entries") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
                return
            }

            do {
                let entries = try JSONDecoder().decode([Entry].self, from: data)
                completion(.success(entries))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
