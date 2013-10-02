class WikiBackupController < ApplicationController
  layout "wiki_backup"

  accept_api_auth :index, :show

  def index
    redirect_to wiki_backup_path(:project_id => "infra")
  end

  def show
    @project = Project.find(params[:project_id].to_s)
    @wiki = @project.wiki
    @page = @wiki.find_page(params[:id])
    @content = @page.content_for_version()
    # second select box
    @pages = @wiki.pages.with_updated_on.all(:order => 'title', :include => {:wiki => :project})
    @pages_by_parent_id = @pages.group_by(&:parent_id)
  end

###  private
###  def missing_template
###    binding.pry
###  end
end
