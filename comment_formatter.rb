class CommentFormatter
  def initialize(comments, title)
    @comments = comments
    @title = title
  end

  def to_md
    section = %(## #{@title}
- #{@comments.length} comments
)

    if @comments.length <= 0
      return section
    end

    section + %(### Details
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
