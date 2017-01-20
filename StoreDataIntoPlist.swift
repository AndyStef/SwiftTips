1) Get the directory: 

func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    
    func dataFilePath()->String {
        return (documentsDirectory() as NSString).stringByAppendingPathComponent("Movies.plist")
    }
    
2) Encode object into file in binary view(Movie should conform to NSCoding protocol): 

func saveMovies() {
        let data = NSMutableData()
        let archiever = NSKeyedArchiver(forWritingWithMutableData: data)
        archiever.encodeObject(movies, forKey: "Movies")
        archiever.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
3)Example of coding/decoding: 

required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("Name") as! String
        productionYear = aDecoder.decodeIntegerForKey("Year")
        producer = aDecoder.decodeObjectForKey("Producer") as! String
        price = aDecoder.decodeIntegerForKey("Price")
        image = aDecoder.decodeObjectForKey("Image") as! String
        rating = aDecoder.decodeIntegerForKey("Rating")
        technology = aDecoder.decodeObjectForKey("Technology") as! String
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name,forKey: "Name")
        aCoder.encodeInteger(productionYear, forKey: "Year")
        aCoder.encodeObject(producer,forKey: "Producer")
        aCoder.encodeInteger(price, forKey: "Price")
        aCoder.encodeObject(image, forKey: "Image")
        aCoder.encodeInteger(rating, forKey: "Rating")
        aCoder.encodeObject(technology, forKey: "Technology")
    }
    
4) Actually get data from file and decode it: 

func loadMovies() {
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiever = NSKeyedUnarchiver(forReadingWithData: data)
                movies = unarchiever.decodeObjectForKey("Movies") as! [Movie]
                unarchiever.finishDecoding()
            }
        }
    }
