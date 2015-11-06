RedmineApp::Application.routes.draw do
  match 'groupprivate/show', :controller => 'groupprivate', :action => 'show', :via => [:get]
  match 'groupprivate/write', :controller => 'groupprivate', :action => 'write', :via => [:get, :post]
  match 'groupprivate/showform', :controller => 'groupprivate', :action => 'showform', :via => [:get, :post]
  match 'projects/:project_id/wiki/:id/change_privacy/:private', :controller => 'wiki', :action => 'change_privacy', :via => [:post]
end

# post 'redmine_private_wiki', :controller => 'groupprivate', :action => 'index'
# post 'redminePrivateWiki', :controller => 'groupprivate', :action => 'index'