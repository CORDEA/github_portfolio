class PullRequestFormatter
  def initialize(prs, title)
    @prs = prs
    @title = title
  end

  def to_md
    section = %(## #{@title}
- #{@prs.length} pull requests
- `+#{@prs.sum {|pr| pr.additions}}` `-#{@prs.sum {|pr| pr.deletions}}`
)

    if @prs.length <= 0
      return section
    end

    section + %(### Details
#{@prs.map(&method(:format)).join("\n")}
    )
  end

  private

  def format(pr)
    %(
#### #{pr.title}
- #{pr.html_url}
- Commits: #{pr.commits}
- `+#{pr.additions}`, `-#{pr.deletions}`
- Files changed: #{pr.changed_files})
  end
end
