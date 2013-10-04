RedmineApp::Application.routes.draw do
  get 'wiki_backup', :to => 'wiki_backup#index', :as => 'wiki_backup_index'
  get 'wiki_backup/:project_id(/:id)', :to => 'wiki_backup#show', :as => 'wiki_backup'
  get 'wiki_backup/attachments/:id/:filename', :controller => 'attachments', :action => 'show', :id => /\d+/, :filename => /.*/,
                                               :context => 'wiki_backup'
  get 'wiki_backup/attachments/download/:id/:filename', :controller => 'attachments', :action => 'download', :id => /\d+/, :filename => /.*/,
                                                        :context => 'wiki_backup'
  get 'wiki_backup/attachments/download/:id', :controller => 'attachments', :action => 'download',
                                              :context => 'wiki_backup'
  get 'wiki_backup/attachments/thumbnail/:id(/:size)', :controller => 'attachments', :action => 'thumbnail', :size => /\d+/,
                                                       :context => 'wiki_backup'
end
