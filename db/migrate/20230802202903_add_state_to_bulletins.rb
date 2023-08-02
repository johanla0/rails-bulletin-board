class AddStateToBulletins < ActiveRecord::Migration[7.0]
  def change
    add_column :bulletins, :state, :string
  end
end
