RedmineApp::Application.routes.draw do
  get 'wiki_backup', :to => 'wiki_backup#index', :as => 'wiki_backup_index'
  get 'wiki_backup/:project_id/wiki(/:id)', :to => 'wiki_backup#show', :as => 'wiki_backup'
end
