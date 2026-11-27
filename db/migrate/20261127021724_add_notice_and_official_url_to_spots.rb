class AddNoticeAndOfficialUrlToSpots < ActiveRecord::Migration[8.1]
  def change
    add_column :spots, :notice, :string
    add_column :spots, :official_url, :string
  end
end
