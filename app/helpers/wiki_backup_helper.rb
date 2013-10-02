module WikiBackupHelper
  def projects
    projects_with_existing_wiki = Wiki.includes(:project)
                                      .where(:id => WikiPage.pluck(:wiki_id))
                                      .pluck(:project_id) 
    @projects ||= Project.active
                         .has_module(:wiki)
                         .where(:id => projects_with_existing_wiki)
  end

  def project_options
    ary = []
    Project.project_tree(projects) do |project, level|
      title = "#{level == 0 ? "" : "--" * level + " " }#{project.name}"
      ary << [title, project.identifier, {"data-link" => wiki_backup_path(:project_id => project.identifier)}]
    end
    ary
  end

  def project_pages_options(pages, node=nil, level = 0)
    ary = []
    if pages[node]
      pages[node].each do |page|
        title = "#{level == 0 ? "" : "--" * level + " "}#{h(page.pretty_title)}"
        ary << [title, page.id, {"data-link" => wiki_backup_path(:project_id => page.project.identifier, :id => page.title)}]
        ary += project_pages_options(pages, page.id, level + 1) if pages[page.id]
      end
    end
    ary
  end

  def other_formats_links(&block)
    #nothing for wiki backups!
  end
end
