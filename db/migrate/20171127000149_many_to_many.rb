class ManyToMany < ActiveRecord::Migration[5.1]
  def change
	  create_table "subscriptions" do |t|
	  	t.belongs_to :user, index: true
	  	t.belongs_to :satellite, index: true
	  end
  end
end
