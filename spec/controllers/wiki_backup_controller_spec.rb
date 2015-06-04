require "spec_helper"

describe WikiBackupController, type: :controller do
  fixtures :wikis, :wiki_pages, :wiki_contents, :wiki_content_versions,
           :projects, :enabled_modules

  describe "#index" do
    it "redirects to the main project" do
      get :index
      expect(response).to redirect_to wiki_backup_path("infra")
    end

    #TODO: for now the main project is hardcoded as "infra"
    it "redirect to the first project if no main project"
  end

  describe "#show" do
    render_views

    let!(:project) { Project.find(1) }
    let!(:wiki) { project.wiki }
    let!(:start_page) { wiki.find_page(id=nil) }
    let!(:other_page) { wiki.find_page("Another_page") }

    it "display a wiki page" do
      get :show, :project_id => project, :id => other_page.title
      expect(assigns(:project)).to eq project
      expect(assigns(:wiki)).to eq wiki
      expect(assigns(:page)).to eq other_page
    end

    it "redirects to the wiki start page if no id" do
      get :show, :project_id => project
      expect(response).to redirect_to wiki_backup_path(:project_id => project, :id => start_page.title, :format => :html)
    end

    it "gets latest content for a page" do
      get :show, :project_id => project, :id => other_page.title
      expect(assigns(:content)).to be_present
    end

    it "doesn't break if page is blank" do
      WikiPage.delete_all
      get :show, :project_id => project
      expect(response.code).to eq "404"
    end

    it "doesn't break if content is blank" do
      WikiContent.delete_all
      get :show, :project_id => project, :id => start_page.title
    end
  end
end
