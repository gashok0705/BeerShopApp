import Foundation
 

public class BeerModel {
	public var abv : String? = ""
	public var ibu : String? = ""
	public var id : Int? = 0
	public var name : String? = ""
	public var style : String? = ""
	public var ounces : Int? = 0
    public var isSelected: Bool = false

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let BeerModel = BeerModel.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of BeerModel Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [BeerModel]
    {
        var models:[BeerModel] = []
        for item in array
        {
            models.append(BeerModel(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let BeerModel = BeerModel(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: BeerModel Instance.
*/
	required public init?(dictionary: NSDictionary) {

		abv = dictionary["abv"] as? String
		ibu = dictionary["ibu"] as? String
		id = dictionary["id"] as? Int
		name = dictionary["name"] as? String
		style = dictionary["style"] as? String
		ounces = dictionary["ounces"] as? Int
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.abv, forKey: "abv")
		dictionary.setValue(self.ibu, forKey: "ibu")
		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.name, forKey: "name")
		dictionary.setValue(self.style, forKey: "style")
		dictionary.setValue(self.ounces, forKey: "ounces")

		return dictionary
	}

}
