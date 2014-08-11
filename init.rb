Redmine::Plugin.register :redmine_wiki_backup do
  name 'Redmine Wiki Backup plugin'
  author 'Jean-Baptiste BARTH'
  description 'Backup your wiki pages as a statci website'
  version '0.0.1'
  url 'https://github.com/jbbarth/redmine_wiki_backup'
  author_url 'jeanbaptiste.barth@gmail.com'
  requires_redmine_plugin :redmine_base_rspec, :version_or_higher => '0.0.3' if Rails.env.test?
end
