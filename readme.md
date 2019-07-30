# Monzo Engineering Demo

### Pods Used

  - SDWebImage - Used for fetching remote images. I would usually use AlamofireImage, but SDWebImage was already in the pod spec, so I just ran with it
  - RxSwift/RxCocoa - For handling asynchronous events
  - Alamofire / RxAlamofire - Networking
  - SnapKit - Autolayout DSL (my personal favorite), to avoid using the verbose built in API. I also much prefer doing my UI's programattically - it get's tricky, especially on big projects, doing a diff on a storyboard! I've found it is ultimately far fewer headaches doing it this way.
  - RealmSwift / RxRealm - Persistence
  - RxRealmDataSources - Just a simple way of linking a Realm DB changeset to a UITableView.
  - NSObject-Rx - Just a nice pod that allows you to avoid writing `let disposeBag = DisposeBag` in every single ViewController!
  - MBProgressHUD - Just for throwing up a small loading screen

### Installation

Clone / download the repo. Navigate to the repo and run

```sh
pod install
```

If you have a previous version of the app on your device / simulator, it will be necessary to delete it from the device, or to 'reset content and settings' and the simulator, because the realm schema will have changed. Normally I'd handle this with a custom Realm configuration, so we can avoid painful migrations - but I ran out of time!

### Notes

My focus was two fold: first, architecture, second, as much UI as possible! I spent about half of my time just on building up a good infastructure for the networking, model, and persistance. Luckly this wasn't too time consuming, as most of the infrastructure here is 'boiler plate' for me. My own feeling is that this is the foundation of the house - you can put as much pretty trim on the walls if you like, but if the foundation is weak, the house will crumble. The second focus then was on UI, and how much I could get done in the remaining time! I focused again on the primary article view, as this was the sort of 'main' thrust of the app. My personal 'approach' is usually - architecture first, then making it match the design, and then finally, time permitting, animations. Animations, while lovely, I find are often more time consuming than you first anticipated, so I generally save these sorts of 'bells and whistles' things for the end. Clearly, I ran out of time here!

If I had another couple of days to work on the feature, my priorities would have been first, finish the ui! Second, write unit tests. Third, add animations. My only gripe for the UI design would be that the white text on the articles image can get washed out - I added the gradient from the spec, but it wasn't quite dark enough in my opinion. But this is a fairly minor tweak!

As for exisiting bugs that may not have been squashed, I believe I got them all just by redoing the architecture, and how the model was persisted / displayed. However, I did realize as I was looking over the code this morning that I totally forgot to serialize the date coming from the API...doh! I would likely handle it with a simple extension to the Date class, and use a DateFormatter to handle whatever particular date format came through (lordy knows there are quite a few!)