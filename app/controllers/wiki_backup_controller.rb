class WikiBackupController < ApplicationController
  helper :all
  layout "wiki_backup"

  accept_api_auth :index, :show

  def index
    redirect_to wiki_backup_path(:project_id => "infra")
  end

  def show
    # show wiki page should only receive HTML GET request
    render_404 if request.format.to_s.include?('image')

    @project = Project.find(params[:project_id].to_s)
    @wiki = @project.wiki
    @page = @wiki.find_page(params[:id])
    @page = @wiki.find_page(@wiki.start_page) if @page.nil?
    if @page && params[:id].present?
      @content = @page.content_for_version()
      # second select box
      @pages = @wiki.pages.with_updated_on.order('title').includes(:wiki => :project)
      @pages_by_parent_id = @pages.group_by(&:parent_id)
    elsif @page
      #... with params[:id] blank, redirect to start page
      redirect_to :id => @page.title, :format => :html
    else
      #no page, no :id, let's call it a 404
      render_404
    end
  end

  def history
    redirect_to history_project_wiki_page_path(id: params[:id], project_id: params[:project_id])
  end
end
