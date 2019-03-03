class CommentFormatter
  def initialize(comments, title)
    @comments = comments
    @title = title
  end

  def to_md()
    %(## #{@title}
- #{@comments.length} comments

### Details
#{@comments.map(&method(:format)).join("\n")}
    )
  end

  private

  def format(comment)
    %(
- #{comment.html_url}

    #{comment.body}
    )
  end
end
