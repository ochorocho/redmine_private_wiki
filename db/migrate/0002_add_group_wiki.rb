class AddGroupWiki < ActiveRecord::Migration
 
  def self.up
    add_column(:wiki_pages, "group", :string)
  end

  def self.down
    remove_column(:wiki_pages, "group")
  end
end
