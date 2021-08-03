module WikiBackupHelper
  def projects
    projects_with_existing_wiki = Wiki.includes(:project)
                                      .where(:id => WikiPage.pluck(:wiki_id))
                                      .pluck(:project_id) 
    @projects ||= Project.visible
                         .active
                         .has_module(:wiki)
                         .where(:id => projects_with_existing_wiki)
  end

  def project_options
    ary = []
    Project.project_tree(projects) do |project, level|
      title = "#{level == 0 ? "" : "--" * level + " " }#{project.name}"
      ary << [title, project.identifier, {"data-link-id" => "wiki_project_#{project.identifier}", "data-start-page" => project.wiki.start_page}]
    end
    ary
  end

  def project_pages_options(pages, node=nil, level = 0)
    ary = []
    if pages[node]
      pages[node].each do |page|
        title = "#{level == 0 ? "" : "--" * level + " "}#{h(page.pretty_title)}"
        ary << [title, page.title, {"data-link-id" => "wiki_page_#{page.id}"}]
        ary += project_pages_options(pages, page.id, level + 1) if pages[page.id]
      end
    end
    ary
  end

  def other_formats_links(&block)
    #nothing for wiki backups!
  end

  def url_for(options = {})
    if options.is_a?(Hash)
      #patch links to wiki pages
      if options[:controller] == 'wiki' && options[:context] != 'top_menu' && options[:action] != 'new'
        options[:controller] = 'wiki_backup'
      end
      #patch links to attachments
      #it just adds an option so that the route that will be picked will be the one with the '/wiki_backup'
      #prefix, so wget --mirror actually mirror those files too.
      if options[:controller] == 'attachments' && options[:action].in?(%w(download show thumbnail))
        options[:context] = 'wiki_backup'
        # add filename automatically so that we don't have both attachments/1234 AND attachments/1234/name.jpg,
        # which would lead wget to not create the first one and point to the directory, while we actually want
        # the file to be served...
        options[:filename] = options[:id].filename if options[:filename].blank? && options[:id].is_a?(Attachment)
      end
    end
    super
  end
end
