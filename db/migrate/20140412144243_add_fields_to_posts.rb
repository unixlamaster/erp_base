class AddFieldsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :chif_id, :integer
    add_column :posts, :chif_name, :string
    add_column :posts, :wobj_name, :string
    add_column :posts, :brigada, :string
    add_column :posts, :amount, :string
    add_column :posts, :staff_name, :string
  end
end
