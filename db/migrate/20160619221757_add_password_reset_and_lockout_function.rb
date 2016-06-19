class AddPasswordResetAndLockoutFunction < ActiveRecord::Migration
  def change
    add_column :users, :reset_token, :string
    add_column :users, :reset_sent_at, :datetime
    add_column :users, :login_lockout_count, :integer, default: 0
    add_column :users, :account_lockout, :boolean, default: false
  end
end
