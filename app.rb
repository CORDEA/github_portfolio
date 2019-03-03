require 'dotenv/load'
require 'octokit'
require './query_builder'
require './pr_formatter'
require './comment_formatter'
require './issue_formatter'


def fetch_prs(client, builder)
  prs = client.search_issues(builder.pr_query)
  pr_numbers = prs.items.map {|pr| pr.number}
  pr_details = pr_numbers.map {|number| client.pull_request(repo, number)}
  pr_formatter = PullRequestFormatter.new(pr_details)
  puts prs.total_count
  puts pr_formatter.format
end

def fetch_reviewed_prs(client, builder)
  prs = client.search_issues(builder.reviewed_pr_query)
  pr_numbers = prs.items.map {|pr| pr.number}
  pr_details = pr_numbers.map {|number| client.pull_request(repo, number)}
  pr_formatter = PullRequestFormatter.new(pr_details)
  puts prs.total_count
  puts pr_formatter.format

  comments = pr_numbers.flat_map {|number| client.issue_comments(repo, number)}
  review_comments = pr_numbers.flat_map {|number| client.pull_request_reviews(repo, number)}
  comment_formatter = CommentFormatter.new(comments)
  review_comment_formatter = CommentFormatter.new(review_comments)
  puts comments.length
  puts comment_formatter.format
  puts review_comments.length
  puts review_comment_formatter.format
end

def fetch_issues(client, builder)
  issues = client.search_issues(builder.issue_query)
  if issues.total_count <= 0
    return
  end
  formatter = IssueFormatter.new(issues.items)
  puts issues.total_count
  puts formatter.format
end

def fetch
  repo = ARGV[0]
  user = ARGV[1]
  date_range = ARGV[2]
  client = Octokit::Client.new(access_token: ENV['ACCESS_TOKEN'], auto_paginate: true)
  builder = QueryBuilder.new(repo, user, date_range)
  fetch_issues(client, builder)
end

fetch
