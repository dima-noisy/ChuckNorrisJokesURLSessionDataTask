import Foundation

enum DownloadError: Error {
    case errorAnswerCode
    case dataIsNil
    case error(Error)
}

class DownloadManager {
    func downloadRandomJoke(completion: ((Result<String, DownloadError>) -> Void)?) {
        let session = URLSession.shared
        let url = URL(string: "https://api.chucknorris.io/jokes/random")
        let task = session.dataTask(with: url!) { data, responce, error in
            if error != nil {
                print(error!.localizedDescription)
                completion?(.failure(.error(error!)))
                return
            }
            
            if let httpUrlResponce = responce as? HTTPURLResponse, httpUrlResponce.statusCode != 200 {
                print("Error, code of responce: \(httpUrlResponce.statusCode)")
                completion?(.failure(.errorAnswerCode))
                return
            }
            
            guard let data else {
                print("No Data")
                
                completion?(.failure(.dataIsNil))
                return
            }
            
            do {
                let answer = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                let jokeText = answer?["value"] as? String ?? "😘"
                completion?(.success(jokeText))
//                print(jokeText)
            } catch {
                print("Error of parsing: \(error.localizedDescription)")
            }
            
        }
        task.resume()
    }
}
