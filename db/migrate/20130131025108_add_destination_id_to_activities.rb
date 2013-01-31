class AddDestinationIdToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :destination_id, :integer
  end
end
