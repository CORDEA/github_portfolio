class PullRequestFormatter
  def initialize(prs)
    @prs = prs
  end

  def format
    @prs.map(&method(:print)).join("\n")
  end

  private

  def print(pr)
    "#{pr.title}\n#{pr.html_url}\n\t#{pr.commits}\n\t+#{pr.additions}\n\t-#{pr.deletions}\n\t#{pr.changed_files}"
  end
end
