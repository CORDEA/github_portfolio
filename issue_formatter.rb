class IssueFormatter
  def initialize(issues)
    @issues = issues
  end

  def to_md
    section = %(## Issues
- #{@issues.length} issues
)

    if @issues.length <= 0
      return section
    end

    section + %(### Details
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
