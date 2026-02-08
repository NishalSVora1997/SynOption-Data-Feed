abstract class FeedEvent {}

class FeedFetched extends FeedEvent {}
class FeedRefreshed extends FeedEvent {}
class FeedRetry extends FeedEvent {}
class FeedSortToggled extends FeedEvent {}