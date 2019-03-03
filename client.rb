require './reviewed_prs'

class Client

  def initialize(client, builder)
    @client = client
    @builder = builder
  end

  def fetch_prs(repo)
    prs = @client.search_issues(@builder.pr_query)
    pr_numbers = prs.items.map {|pr| pr.number}
    pr_numbers.map {|number| @client.pull_request(repo, number)}
  end

  def fetch_reviewed_prs(repo, author)
    prs = @client.search_issues(@builder.reviewed_pr_query)
    pr_numbers = prs.items.map {|pr| pr.number}
    pr_details = pr_numbers.map {|number| @client.pull_request(repo, number)}
    reviewed_comments = fetch_reviewed_comments(repo, pr_numbers, author)
    comments = fetch_comments(repo, pr_numbers, author)
    ReviewedPullRequests.new(pr_details, reviewed_comments, comments)
  end

  def fetch_issues
    @client.search_issues(@builder.issue_query).items
  end

  def fetch_assigned_issues
    @client.search_issues(@builder.assigned_issue_query).items
  end

  private

  def fetch_reviewed_comments(repo, numbers, author)
    numbers
        .flat_map {|number| @client.pull_request_comments(repo, number)}
        .select {|issue| issue.user.login == author}
  end

  def fetch_comments(repo, numbers, author)
    numbers
        .flat_map {|number| @client.issue_comments(repo, number)}
        .select {|issue| issue.user.login == author}
  end
end
