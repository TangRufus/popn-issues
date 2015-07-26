crumb :root do
  link "Home", root_path
end

crumb :issues do
  link "Issues", issues_path
end

crumb :issue do |issue|
  link issue.title, issue_path(issue)
  parent :issues
end
