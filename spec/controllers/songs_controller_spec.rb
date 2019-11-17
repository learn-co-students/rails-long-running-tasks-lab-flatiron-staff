require 'rails_helper'

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

RSpec.describe SongsController do
  describe "file upload" do
    before do
      Song.destroy_all
      Artist.destroy_all
    end

    it "uploads and processes a file" do
      post :upload, song: {csv: fixture_file_upload('songs.csv', 'text/csv')}
      expect(Song.all.count).to eq 13
      expect(Artist.all.count).to eq 6
    end
  end
end
