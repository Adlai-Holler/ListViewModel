
import Foundation
import ReactiveCocoa

public class ListViewModel: NSObject {
    private(set) public dynamic var hasDoneInitialLoad = false
    private(set) public dynamic var refreshingError: NSError? = nil
    private(set) public dynamic var loadingError: NSError? = nil
    
    // TODO: consider removing these and documenting how to make them
    private(set) public dynamic var loadingMore = false
    private(set) public dynamic var reloading = false
    
    private(set) public dynamic var loadingMoreError: NSError? = nil
    /// TODO: rather than array, use some structure that sends changes
    private(set) public dynamic var items: [AnyObject] = []
    
    /// Subclasses should set these
    private(set) public var loadCommand: RACCommand!
    private(set) public var loadMoreCommand: RACCommand!
    private(set) public var reloadCommand: RACCommand!
    
    override init() {
        super.init()
        loadCommand.executionSignals.switchToLatest().take(1).mapReplace(true).setKeyPath("hasDoneInitialLoad", onObject: self)
        reloadCommand.errors.setKeyPath("refreshingError", onObject: self)
        loadCommand.errors.setKeyPath("loadingError", onObject: self)
        loadMoreCommand.executing.setKeyPath("loadingMore", onObject: self)
        loadMoreCommand.errors.setKeyPath("loadingMoreError", onObject: self)
        reloadCommand.executing.setKeyPath("reloading", onObject: self)
    }

}
