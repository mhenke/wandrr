class Activity < ActiveRecord::Base
  attr_accessible :description, :name
  belongs_to :destination
end
