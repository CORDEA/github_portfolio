class CommentFormatter
  def initialize(comments)
    @comments = comments
  end

  def format()
    @comments.map(&method(:print)).join("\n")
  end

  private

  def print(comment)
    "#{comment._links.html.href}\n#{comment.body}"
  end
end
