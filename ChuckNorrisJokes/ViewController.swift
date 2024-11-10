import UIKit

class ViewController: UIViewController {
    
    var downloadManager = DownloadManager()

    @IBOutlet weak var labelJoke: UILabel!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBOutlet weak var reftrshButton: UIButton!
    @IBAction func pushRefreshButton(_ sender: Any) {
        indicator.startAnimating()
        reftrshButton.isEnabled = false
        downloadManager.downloadRandomJoke { [weak self] result in
            
            switch result {
            case .success(let jokeText):
                DispatchQueue.main.async {
                    self?.labelJoke.text = jokeText
                }
            case .failure(let error):
                
                print(error.localizedDescription)
                break
            }
            DispatchQueue.main.async {
                self?.indicator.stopAnimating()
                self?.reftrshButton.isEnabled = true
            }
        }
    }
    
}

