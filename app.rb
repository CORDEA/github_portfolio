require 'dotenv/load'
require 'octokit'
require './query_builder'
require './pr_formatter'
require './comment_formatter'
require './issue_formatter'
require './reviewed_prs'
require './client'


def show_prs(client, repo)
  prs = client.fetch_prs(repo)
  pr_formatter = PullRequestFormatter.new(prs, "Pull requests")
  puts pr_formatter.to_md
end

def show_reviewed_prs(client, repo, author)
  prs = client.fetch_reviewed_prs(repo, author)
  pr_formatter = PullRequestFormatter.new(prs.prs, "Reviewed pull requests")
  comment_formatter = CommentFormatter.new(prs.comments, "Comments")
  review_comment_formatter = CommentFormatter.new(prs.reviewed_comments, "Review comments")
  puts pr_formatter.to_md
  puts comment_formatter.to_md
  puts review_comment_formatter.to_md
end

def show_issues(client)
  issues = client.fetch_issues
  if issues.length <= 0
    return
  end
  formatter = IssueFormatter.new(issues)
  puts formatter.to_md
end

def fetch
  repo = ARGV[0]
  user = ARGV[1]
  date_range = ARGV[2]
  baseClient = Octokit::Client.new(access_token: ENV['ACCESS_TOKEN'], auto_paginate: true)
  builder = QueryBuilder.new(repo, user, date_range)
  client = Client.new(baseClient, builder)

  puts %(# GitHub portfolio

- #{user}
- #{repo}
- #{date_range}
       )
  show_issues(client)
  show_prs(client, repo)
  show_reviewed_prs(client, repo, user)
end

fetch
