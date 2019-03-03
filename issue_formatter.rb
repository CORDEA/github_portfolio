class IssueFormatter
  def initialize(issues)
    @issues = issues
  end

  def to_md
    %(## Issues
- #{@issues.length} issues

### Details
#{@issues.map(&method(:format)).join("\n")}
    )
  end

  private

  def format(issue)
    %(
#### #{issue.title}
- #{issue.html_url})
  end
end
