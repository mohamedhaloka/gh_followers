
import UIKit

class GFAvatarImage: UIImageView {
    
    let cache = NetworkManager.shared.cache
    
    let imagePlaceHolder =  UIImage(named: "avatar-placeholder")
    
    static let resuableUd = "avatar-image"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        confirgure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func confirgure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = imagePlaceHolder
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    public func downloadImage(from urlString : String)
    {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey)
        {
            self.image = image
            return
        }
        
        
        let url = URL(string: urlString)
        
        guard let url = url else{
            return;
        }
        
        let session = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            
            guard let self = self else {
                return
            }
            
            if(error != nil)
            {
                return ;
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                return
            }
            
            guard let data = data else{
                return ;
            }
            guard let image = UIImage(data: data) else {
                return ;
            }

            DispatchQueue.main.async {
                self.image = image
                self.cache.setObject(image, forKey: cacheKey)
            }
            
        }
        
        session.resume()
    }

}
