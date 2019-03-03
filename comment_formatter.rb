class CommentFormatter
  def initialize(comments)
    @comments = comments
  end

  def to_md()
    %(## Review comments
- #{@comments.length} comments

### Details
#{@comments.map(&method(:format)).join("\n")}
    )
  end

  private

  def format(comment)
    %(
- #{comment._links.html.href}

```
#{comment.body}
```)
  end
end
