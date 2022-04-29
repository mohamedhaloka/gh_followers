

enum GFError :  String , Error{
    case urlError           = "Error in URL, please try again"
    case makeRequestEror    = "Error in Make Request, please try again"
    case responseError      = "Error in response, please try again"
    case errorData          = "Error in Data, please try again"
    case unableToFavorie          = "unable to add this person to favorite"
    case alreadyInFav          = "this user already in fav"
}
