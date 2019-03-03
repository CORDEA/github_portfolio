class ReviewedPullRequests
  attr_reader :prs, :reviewed_comments, :comments

  def initialize(prs, reviewed_comments, comments)
    @prs = prs
    @reviewed_comments = reviewed_comments
    @comments = comments
  end
end
