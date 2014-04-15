class WikiBackupController < ApplicationController
  helper :all
  layout "wiki_backup"

  accept_api_auth :index, :show

  def index
    redirect_to wiki_backup_path(:project_id => "infra")
  end

  def show
    @project = Project.find(params[:project_id].to_s)
    @wiki = @project.wiki
    @page = @wiki.find_page(params[:id])
    @page = @wiki.find_page(@wiki.start_page) if @page.nil?
    if params[:id].blank?
      redirect_to :id => @page.title, :format => :html
    else
      @content = @page.content_for_version()
      # second select box
      @pages = @wiki.pages.with_updated_on.all(:order => 'title', :include => {:wiki => :project})
      @pages_by_parent_id = @pages.group_by(&:parent_id)
    end
  end

###  private
###  def missing_template
###    binding.pry
###  end
end
