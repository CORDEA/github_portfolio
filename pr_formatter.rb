class PullRequestFormatter
  def initialize(prs)
    @prs = prs
  end

  def to_md
    %(## Pull Requests
- #{@prs.length} pull requests
- `+#{@prs.sum {|pr| pr.additions}}` `-#{@prs.sum {|pr| pr.deletions}}`

### Details
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
