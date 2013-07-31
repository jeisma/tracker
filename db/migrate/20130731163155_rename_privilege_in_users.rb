class RenamePrivilegeInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :priviliged, :privileged
  end
end
