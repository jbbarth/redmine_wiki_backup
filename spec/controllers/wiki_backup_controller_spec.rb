require "spec_helper"

describe WikiBackupController do
  describe "#index" do
    it "redirects to the main project" do
      get :index
      response.should redirect_to wiki_backup_path("infra")
    end

    #TODO: for now the main project is hardcoded as "infra"
    it "redirect to the first project if no main project"
  end

  describe "#show" do
  end
end
