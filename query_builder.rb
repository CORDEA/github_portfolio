class QueryBuilder
  def initialize(repo, author, created)
    @repo = repo
    @author = author
    @created = created
  end

  def pr_query
    "is:pr repo:#{@repo} author:#{@author} created:#{@created}"
  end

  def reviewed_pr_query
    "is:pr repo:#{@repo} reviewed-by:#{@author} -author:#{@author} created:#{@created}"
  end

  def issue_query
    "is:issue repo:#{@repo} author:#{@author} created:#{@created}"
  end

  def assigned_issue_query
    "is:issue repo:#{@repo} assignee:#{@author} -author:#{@author} created:#{@created}"
  end
end
