class IssueFormatter
  def initialize(issues)
    @issues = issues
  end

  def format
    @issues.map(&method(:print)).join("\n")
  end

  private

  def print(issue)
    "#{issue.title}\n#{issue.html_url}"
  end
end
