class IssueFormatter
  def initialize(issues, title)
    @issues = issues
    @title = title
  end

  def to_md
    section = %(## #{@title}
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
#### [#{issue.state.upcase}] #{issue.title}
- #{issue.html_url})
  end
end
