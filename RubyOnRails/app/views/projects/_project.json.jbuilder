json.extract! project, :id, :projectname, :projecttype, :date, :created_at, :updated_at
json.url project_url(project, format: :json)
